from typing import Any, Dict, List, Optional, Union
from datetime import datetime, timedelta
from sqlalchemy.orm import Session
from sqlalchemy import func, and_

from app.crud.base import CRUDBase
from app.models.tribe import Tribe, TribeMember, TribeVote
from app.schemas.tribe import TribeCreate, TribeUpdate, TribeMemberCreate, TribeVoteCreate


class CRUDTribe(CRUDBase[Tribe, TribeCreate, TribeUpdate]):
    def create_with_owner(
        self, db: Session, *, obj_in: TribeCreate, creator_id: int
    ) -> Tribe:
        # Check if user can create a tribe
        last_tribe = db.query(Tribe).filter(
            Tribe.creator_id == creator_id
        ).order_by(Tribe.created_at.desc()).first()
        
        if last_tribe and last_tribe.created_at > datetime.utcnow() - timedelta(days=30):
            raise ValueError("Users can only create one tribe every 30 days")

        obj_in_data = obj_in.model_dump()
        db_obj = self.model(**obj_in_data, creator_id=creator_id, chief_id=creator_id)
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)

        # Add creator as a member
        member = TribeMember(
            tribe_id=db_obj.id,
            user_id=creator_id,
        )
        db.add(member)
        db.commit()

        return db_obj

    def get_multi_by_owner(
        self, db: Session, *, owner_id: int, skip: int = 0, limit: int = 100
    ) -> List[Tribe]:
        return (
            db.query(self.model)
            .filter(Tribe.creator_id == owner_id)
            .offset(skip)
            .limit(limit)
            .all()
        )

    def get_by_name(self, db: Session, *, name: str) -> Optional[Tribe]:
        return db.query(Tribe).filter(Tribe.name == name).first()

    def add_member(
        self, db: Session, *, tribe_id: int, member_in: TribeMemberCreate
    ) -> TribeMember:
        # Check if user is already a member of another tribe
        existing_membership = (
            db.query(TribeMember)
            .filter(TribeMember.user_id == member_in.user_id)
            .first()
        )
        if existing_membership:
            raise ValueError("User is already a member of another tribe")

        db_obj = TribeMember(**member_in.model_dump())
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj

    def remove_member(
        self, db: Session, *, tribe_id: int, user_id: int
    ) -> Optional[TribeMember]:
        obj = (
            db.query(TribeMember)
            .filter(
                TribeMember.tribe_id == tribe_id,
                TribeMember.user_id == user_id
            )
            .first()
        )
        if obj:
            db.delete(obj)
            db.commit()
        return obj

    def add_vote(
        self, db: Session, *, vote_in: TribeVoteCreate
    ) -> TribeVote:
        # Check if voter is a member of the tribe
        member = (
            db.query(TribeMember)
            .filter(
                TribeMember.tribe_id == vote_in.tribe_id,
                TribeMember.user_id == vote_in.voter_id
            )
            .first()
        )
        if not member:
            raise ValueError("Voter must be a member of the tribe")

        # Check if candidate is a member of the tribe
        candidate_member = (
            db.query(TribeMember)
            .filter(
                TribeMember.tribe_id == vote_in.tribe_id,
                TribeMember.user_id == vote_in.candidate_id
            )
            .first()
        )
        if not candidate_member:
            raise ValueError("Candidate must be a member of the tribe")

        # Remove previous vote if exists
        db.query(TribeVote).filter(
            TribeVote.tribe_id == vote_in.tribe_id,
            TribeVote.voter_id == vote_in.voter_id
        ).delete()

        db_obj = TribeVote(**vote_in.model_dump())
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)

        # Check if we need to update chief
        self._update_chief(db, tribe_id=vote_in.tribe_id)

        return db_obj

    def _update_chief(self, db: Session, *, tribe_id: int) -> None:
        # Get the candidate with most votes
        votes_subq = (
            db.query(
                TribeVote.candidate_id,
                func.count(TribeVote.id).label('vote_count')
            )
            .filter(TribeVote.tribe_id == tribe_id)
            .group_by(TribeVote.candidate_id)
            .subquery()
        )

        top_candidate = (
            db.query(votes_subq)
            .order_by(votes_subq.c.vote_count.desc())
            .first()
        )

        if top_candidate:
            tribe = db.query(Tribe).get(tribe_id)
            if tribe and tribe.chief_id != top_candidate.candidate_id:
                tribe.chief_id = top_candidate.candidate_id
                db.commit()

    def get_tribe_members(
        self, db: Session, *, tribe_id: int, skip: int = 0, limit: int = 100
    ) -> List[TribeMember]:
        return (
            db.query(TribeMember)
            .filter(TribeMember.tribe_id == tribe_id)
            .offset(skip)
            .limit(limit)
            .all()
        )


tribe = CRUDTribe(Tribe)
