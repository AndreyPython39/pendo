from typing import List, Optional
from sqlalchemy.orm import Session
from sqlalchemy import and_

from app.crud.base import CRUDBase
from app.models.moderation import ModerationLog, Photo
from app.schemas.moderation import (
    ModerationLogCreate,
    ModerationLogUpdate,
    PhotoCreate,
    PhotoUpdate,
    ModerationAction,
    ModerationObject
)


class CRUDModerationLog(CRUDBase[ModerationLog, ModerationLogCreate, ModerationLogUpdate]):
    def get_object_logs(
        self, db: Session, *, object_type: ModerationObject, object_id: int
    ) -> List[ModerationLog]:
        return (
            db.query(ModerationLog)
            .filter(
                ModerationLog.object_type == object_type,
                ModerationLog.object_id == object_id
            )
            .order_by(ModerationLog.created_at.desc())
            .all()
        )

    def get_moderator_actions(
        self, db: Session, *, moderator_id: int, skip: int = 0, limit: int = 100
    ) -> List[ModerationLog]:
        return (
            db.query(ModerationLog)
            .filter(ModerationLog.moderator_id == moderator_id)
            .order_by(ModerationLog.created_at.desc())
            .offset(skip)
            .limit(limit)
            .all()
        )


class CRUDPhoto(CRUDBase[Photo, PhotoCreate, PhotoUpdate]):
    def get_user_photos(
        self, db: Session, *, user_id: int
    ) -> List[Photo]:
        return (
            db.query(Photo)
            .filter(Photo.user_id == user_id)
            .order_by(Photo.is_primary.desc(), Photo.created_at.desc())
            .all()
        )

    def get_primary_photo(
        self, db: Session, *, user_id: int
    ) -> Optional[Photo]:
        return (
            db.query(Photo)
            .filter(
                Photo.user_id == user_id,
                Photo.is_primary == True
            )
            .first()
        )

    def set_primary_photo(
        self, db: Session, *, user_id: int, photo_id: int
    ) -> Photo:
        # Reset all user's photos to non-primary
        db.query(Photo).filter(
            Photo.user_id == user_id,
            Photo.is_primary == True
        ).update({"is_primary": False})

        # Set the selected photo as primary
        photo = db.query(Photo).get(photo_id)
        if photo and photo.user_id == user_id:
            photo.is_primary = True
            db.commit()
            db.refresh(photo)
            return photo
        raise ValueError("Photo not found or doesn't belong to user")

    def get_pending_photos(
        self, db: Session, *, skip: int = 0, limit: int = 100
    ) -> List[Photo]:
        return (
            db.query(Photo)
            .filter(Photo.moderation_status == "pending")
            .order_by(Photo.created_at.asc())
            .offset(skip)
            .limit(limit)
            .all()
        )

    def moderate_photo(
        self, db: Session, *, photo_id: int, moderator_id: int, 
        status: str, reason: Optional[str] = None
    ) -> Photo:
        photo = db.query(Photo).get(photo_id)
        if not photo:
            raise ValueError("Photo not found")

        photo.moderation_status = status
        photo.moderated_by = moderator_id
        db.commit()
        db.refresh(photo)

        # Create moderation log
        log = ModerationLog(
            moderator_id=moderator_id,
            object_type=ModerationObject.photo,
            object_id=photo_id,
            action=ModerationAction.approve if status == "approved" else ModerationAction.reject,
            reason=reason
        )
        db.add(log)
        db.commit()

        return photo


moderation_log = CRUDModerationLog(ModerationLog)
photo = CRUDPhoto(Photo)
