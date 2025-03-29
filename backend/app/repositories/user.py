from typing import Optional, List
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, update, delete
from sqlalchemy.orm import joinedload
from app.models.user import User, UserProfile, UserScore
from app.schemas.user import UserCreate, UserUpdate
from app.core.security import get_password_hash
import uuid

class UserRepository:
    def __init__(self, session: AsyncSession):
        self._session = session

    async def create(self, user_in: UserCreate) -> User:
        user = User(
            id=str(uuid.uuid4()),
            email=user_in.email,
            phone=user_in.phone,
            hashed_password=get_password_hash(user_in.password),
            is_active=True,
            is_verified=False,
            is_premium=False
        )
        self._session.add(user)
        
        profile = UserProfile(
            id=str(uuid.uuid4()),
            user_id=user.id,
            name=user_in.name,
            birthdate=user_in.birthdate,
            gender=user_in.gender,
            looking_for=user_in.looking_for,
            bio=user_in.bio,
            interests=user_in.interests,
            temperament=user_in.temperament,
            extra_data=user_in.extra_data,
            profile_photos=user_in.profile_photos,
            pendo_score=0,
            cultural_preferences={}
        )
        self._session.add(profile)
        
        score = UserScore(
            id=str(uuid.uuid4()),
            user_id=user.id,
            score=0,
            level="novice"
        )
        self._session.add(score)
        
        await self._session.commit()
        await self._session.refresh(user)
        return user

    async def get(self, id: str) -> Optional[User]:
        result = await self._session.execute(
            select(User)
            .options(
                joinedload(User.profile),
                joinedload(User.score),
                joinedload(User.current_tribe),
                joinedload(User.stories),
                joinedload(User.streams),
                joinedload(User.gifts_sent),
                joinedload(User.gifts_received)
            )
            .where(User.id == id)
        )
        return result.scalar_one_or_none()

    async def get_by_email(self, email: str) -> Optional[User]:
        result = await self._session.execute(
            select(User)
            .options(joinedload(User.profile))
            .where(User.email == email)
        )
        return result.scalar_one_or_none()

    async def get_by_phone(self, phone: str) -> Optional[User]:
        result = await self._session.execute(
            select(User)
            .options(joinedload(User.profile))
            .where(User.phone == phone)
        )
        return result.scalar_one_or_none()

    async def update(
        self,
        user: User,
        user_in: UserUpdate
    ) -> User:
        update_data = user_in.dict(exclude_unset=True)
        
        if update_data:
            statement = (
                update(User)
                .where(User.id == user.id)
                .values(**update_data)
            )
            await self._session.execute(statement)
            
            # Update profile if needed
            profile_data = {}
            for field in ["name", "bio", "interests", "temperament", "extra_data", "profile_photos"]:
                if field in update_data:
                    profile_data[field] = update_data[field]
            
            if profile_data:
                statement = (
                    update(UserProfile)
                    .where(UserProfile.user_id == user.id)
                    .values(**profile_data)
                )
                await self._session.execute(statement)
            
            await self._session.commit()
            await self._session.refresh(user)
        
        return user

    async def delete(self, id: str) -> bool:
        statement = delete(User).where(User.id == id)
        result = await self._session.execute(statement)
        await self._session.commit()
        return result.rowcount > 0

    async def list_active(
        self,
        skip: int = 0,
        limit: int = 100
    ) -> List[User]:
        result = await self._session.execute(
            select(User)
            .options(joinedload(User.profile))
            .where(User.is_active == True)
            .offset(skip)
            .limit(limit)
        )
        return result.scalars().all()

    async def update_last_active(self, user: User) -> None:
        from datetime import datetime
        statement = (
            update(User)
            .where(User.id == user.id)
            .values(last_active=datetime.utcnow())
        )
        await self._session.execute(statement)
        await self._session.commit()

    async def verify_email(self, user: User) -> User:
        statement = (
            update(User)
            .where(User.id == user.id)
            .values(is_verified=True)
        )
        await self._session.execute(statement)
        await self._session.commit()
        await self._session.refresh(user)
        return user

    async def set_premium(self, user: User, is_premium: bool) -> User:
        statement = (
            update(User)
            .where(User.id == user.id)
            .values(is_premium=is_premium)
        )
        await self._session.execute(statement)
        await self._session.commit()
        await self._session.refresh(user)
        return user

    async def update_score(
        self,
        user: User,
        score_delta: int
    ) -> UserScore:
        result = await self._session.execute(
            select(UserScore)
            .where(UserScore.user_id == user.id)
        )
        user_score = result.scalar_one()
        
        new_score = user_score.score + score_delta
        new_level = self._calculate_level(new_score)
        
        statement = (
            update(UserScore)
            .where(UserScore.user_id == user.id)
            .values(
                score=new_score,
                level=new_level
            )
        )
        await self._session.execute(statement)
        await self._session.commit()
        await self._session.refresh(user_score)
        return user_score

    def _calculate_level(self, score: int) -> str:
        if score < 100:
            return "novice"
        elif score < 500:
            return "intermediate"
        elif score < 1000:
            return "advanced"
        elif score < 5000:
            return "expert"
        else:
            return "master"
