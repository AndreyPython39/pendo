from typing import List, Optional
from sqlalchemy.orm import Session
from sqlalchemy import or_, and_

from app.crud.base import CRUDBase
from app.models.match import Match, Like, Message
from app.schemas.match import MatchCreate, MatchUpdate, LikeCreate, MessageCreate


class CRUDMatch(CRUDBase[Match, MatchCreate, MatchUpdate]):
    def get_user_matches(
        self, db: Session, *, user_id: int, skip: int = 0, limit: int = 100
    ) -> List[Match]:
        return (
            db.query(Match)
            .filter(
                or_(
                    Match.user1_id == user_id,
                    Match.user2_id == user_id
                ),
                Match.is_active == True
            )
            .offset(skip)
            .limit(limit)
            .all()
        )

    def create_from_like(
        self, db: Session, *, like: Like
    ) -> Optional[Match]:
        # Check if there's a mutual like
        mutual_like = (
            db.query(Like)
            .filter(
                Like.from_user_id == like.to_user_id,
                Like.to_user_id == like.from_user_id
            )
            .first()
        )

        if mutual_like:
            # Create a match
            match = Match(
                user1_id=like.from_user_id,
                user2_id=like.to_user_id,
                is_active=True
            )
            db.add(match)
            db.commit()
            db.refresh(match)
            return match
        return None

    def get_messages(
        self, db: Session, *, match_id: int, skip: int = 0, limit: int = 100
    ) -> List[Message]:
        return (
            db.query(Message)
            .filter(Message.match_id == match_id)
            .order_by(Message.sent_at.desc())
            .offset(skip)
            .limit(limit)
            .all()
        )


class CRUDLike(CRUDBase[Like, LikeCreate, MatchUpdate]):
    def get_by_users(
        self, db: Session, *, from_user_id: int, to_user_id: int
    ) -> Optional[Like]:
        return (
            db.query(Like)
            .filter(
                Like.from_user_id == from_user_id,
                Like.to_user_id == to_user_id
            )
            .first()
        )

    def create_with_match_check(
        self, db: Session, *, obj_in: LikeCreate
    ) -> tuple[Like, Optional[Match]]:
        # Create like
        db_obj = self.create(db, obj_in=obj_in)
        
        # Check for match
        match = None
        mutual_like = (
            db.query(Like)
            .filter(
                Like.from_user_id == obj_in.to_user_id,
                Like.to_user_id == obj_in.from_user_id
            )
            .first()
        )

        if mutual_like:
            match = Match(
                user1_id=obj_in.from_user_id,
                user2_id=obj_in.to_user_id,
                is_active=True
            )
            db.add(match)
            db.commit()
            db.refresh(match)

        return db_obj, match


class CRUDMessage(CRUDBase[Message, MessageCreate, MatchUpdate]):
    def get_chat_messages(
        self, db: Session, *, match_id: int, skip: int = 0, limit: int = 100
    ) -> List[Message]:
        return (
            db.query(Message)
            .filter(Message.match_id == match_id)
            .order_by(Message.sent_at.desc())
            .offset(skip)
            .limit(limit)
            .all()
        )

    def mark_as_read(
        self, db: Session, *, match_id: int, user_id: int
    ) -> int:
        result = (
            db.query(Message)
            .filter(
                Message.match_id == match_id,
                Message.sender_id != user_id,
                Message.is_read == False
            )
            .update({"is_read": True})
        )
        db.commit()
        return result


match = CRUDMatch(Match)
like = CRUDLike(Like)
message = CRUDMessage(Message)
