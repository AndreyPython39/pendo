from typing import List, Optional, Tuple
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, update, delete, func, and_, or_
from sqlalchemy.orm import joinedload
from app.models.user import User, UserProfile
from app.models.match import Match, Swipe
from app.schemas.matching import SwipeCreate
from geoalchemy2.functions import ST_Distance_Sphere
import uuid

class MatchingRepository:
    def __init__(self, session: AsyncSession):
        self._session = session

    async def get_cards(
        self,
        user: User,
        limit: int = 20,
        max_distance: Optional[float] = None,
        min_age: Optional[int] = None,
        max_age: Optional[int] = None,
        gender: Optional[List[str]] = None
    ) -> List[User]:
        # Get user's location
        user_profile = await self._session.get(UserProfile, user.profile.id)
        if not user_profile or not user_profile.location:
            return []

        # Base query
        query = (
            select(User)
            .join(UserProfile)
            .options(
                joinedload(User.profile),
                joinedload(User.score)
            )
            .where(
                and_(
                    User.is_active == True,
                    User.id != user.id,
                    ~User.id.in_(
                        select(Match.user2_id)
                        .where(Match.user1_id == user.id)
                    ),
                    ~User.id.in_(
                        select(Swipe.swiped_id)
                        .where(Swipe.swiper_id == user.id)
                    )
                )
            )
        )

        # Apply filters
        if max_distance:
            query = query.where(
                ST_Distance_Sphere(
                    UserProfile.location,
                    user_profile.location
                ) <= max_distance * 1000  # Convert km to meters
            )

        if min_age and max_age:
            query = query.where(
                and_(
                    func.date_part('year', func.age(UserProfile.birthdate)) >= min_age,
                    func.date_part('year', func.age(UserProfile.birthdate)) <= max_age
                )
            )

        if gender:
            query = query.where(UserProfile.gender.in_(gender))

        # Order by compatibility score and distance
        query = query.order_by(
            func.random()  # Add some randomness
        ).limit(limit)

        result = await self._session.execute(query)
        return result.scalars().all()

    async def create_swipe(
        self,
        swipe_in: SwipeCreate
    ) -> Tuple[Swipe, Optional[Match]]:
        swipe = Swipe(
            id=str(uuid.uuid4()),
            swiper_id=swipe_in.swiper_id,
            swiped_id=swipe_in.swiped_id,
            direction=swipe_in.direction,
            is_super=swipe_in.is_super
        )
        self._session.add(swipe)

        # Check for mutual like
        if swipe_in.direction == "right":
            result = await self._session.execute(
                select(Swipe)
                .where(
                    and_(
                        Swipe.swiper_id == swipe_in.swiped_id,
                        Swipe.swiped_id == swipe_in.swiper_id,
                        Swipe.direction == "right"
                    )
                )
            )
            mutual_swipe = result.scalar_one_or_none()

            if mutual_swipe:
                match = Match(
                    id=str(uuid.uuid4()),
                    user1_id=swipe_in.swiper_id,
                    user2_id=swipe_in.swiped_id,
                    match_score=self._calculate_match_score(
                        swipe.is_super,
                        mutual_swipe.is_super
                    )
                )
                self._session.add(match)
                await self._session.commit()
                return swipe, match

        await self._session.commit()
        return swipe, None

    def _calculate_match_score(
        self,
        is_super1: bool,
        is_super2: bool
    ) -> float:
        base_score = 0.7
        super_bonus = 0.15

        score = base_score
        if is_super1:
            score += super_bonus
        if is_super2:
            score += super_bonus

        return min(score, 1.0)

    async def get_matches(
        self,
        user_id: str,
        skip: int = 0,
        limit: int = 50
    ) -> List[Match]:
        result = await self._session.execute(
            select(Match)
            .options(
                joinedload(Match.user1),
                joinedload(Match.user2)
            )
            .where(
                or_(
                    Match.user1_id == user_id,
                    Match.user2_id == user_id
                )
            )
            .order_by(Match.matched_at.desc())
            .offset(skip)
            .limit(limit)
        )
        return result.scalars().all()

    async def unmatch(
        self,
        match_id: str,
        user_id: str
    ) -> bool:
        result = await self._session.execute(
            delete(Match)
            .where(
                and_(
                    Match.id == match_id,
                    or_(
                        Match.user1_id == user_id,
                        Match.user2_id == user_id
                    )
                )
            )
        )
        await self._session.commit()
        return result.rowcount > 0

    async def get_likes(
        self,
        user_id: str,
        skip: int = 0,
        limit: int = 50
    ) -> List[Swipe]:
        result = await self._session.execute(
            select(Swipe)
            .options(joinedload(Swipe.swiper))
            .where(
                and_(
                    Swipe.swiped_id == user_id,
                    Swipe.direction == "right"
                )
            )
            .order_by(Swipe.created_at.desc())
            .offset(skip)
            .limit(limit)
        )
        return result.scalars().all()
