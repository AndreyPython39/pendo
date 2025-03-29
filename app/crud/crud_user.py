from typing import Any, Dict, Optional, Union, List
from sqlalchemy.orm import Session
from sqlalchemy import select, func
from geoalchemy2.functions import ST_DWithin, ST_Distance, ST_AsText
from geoalchemy2.elements import WKTElement

from app.core.security import get_password_hash, verify_password
from app.crud.base import CRUDBase
from app.models.user import User, UserProfile, UserScore
from app.schemas.user import UserCreate, UserUpdate, UserProfileCreate, UserScoreCreate


class CRUDUser(CRUDBase[User, UserCreate, UserUpdate]):
    def get_by_email(self, db: Session, *, email: str) -> Optional[User]:
        return db.query(User).filter(User.email == email).first()

    def get_by_phone(self, db: Session, *, phone: str) -> Optional[User]:
        return db.query(User).filter(User.phone == phone).first()

    def create(self, db: Session, *, obj_in: UserCreate) -> User:
        db_obj = User(
            email=obj_in.email,
            phone=obj_in.phone,
            hashed_password=get_password_hash(obj_in.password),
            is_active=obj_in.is_active,
            is_superuser=obj_in.is_superuser,
            is_verified=obj_in.is_verified,
            role=obj_in.role,
        )
        if obj_in.location:
            point = f'POINT({obj_in.location.longitude} {obj_in.location.latitude})'
            db_obj.location = WKTElement(point, srid=4326)
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj

    def update(
        self, db: Session, *, db_obj: User, obj_in: Union[UserUpdate, Dict[str, Any]]
    ) -> User:
        if isinstance(obj_in, dict):
            update_data = obj_in
        else:
            update_data = obj_in.model_dump(exclude_unset=True)
        if update_data.get("password"):
            hashed_password = get_password_hash(update_data["password"])
            del update_data["password"]
            update_data["hashed_password"] = hashed_password
        if "location" in update_data:
            location = update_data.pop("location")
            if location:
                point = f'POINT({location.longitude} {location.latitude})'
                update_data["location"] = WKTElement(point, srid=4326)
        return super().update(db, db_obj=db_obj, obj_in=update_data)

    def authenticate(self, db: Session, *, identifier: str, password: str) -> Optional[User]:
        user = None
        if "@" in identifier:
            user = self.get_by_email(db, email=identifier)
        else:
            user = self.get_by_phone(db, phone=identifier)
        if not user:
            return None
        if not verify_password(password, user.hashed_password):
            return None
        return user

    def is_active(self, user: User) -> bool:
        return user.is_active

    def is_superuser(self, user: User) -> bool:
        return user.is_superuser

    def get_nearby_users(
        self, 
        db: Session, 
        *, 
        latitude: float, 
        longitude: float, 
        radius_km: float = 10,
        skip: int = 0,
        limit: int = 50
    ) -> List[User]:
        point = WKTElement(f'POINT({longitude} {latitude})', srid=4326)
        query = db.query(User).filter(
            ST_DWithin(
                User.location, 
                point,
                radius_km * 1000  # Convert km to meters
            )
        ).order_by(
            ST_Distance(User.location, point)
        ).offset(skip).limit(limit)
        return query.all()

    def create_profile(
        self, db: Session, *, user_id: int, profile_in: UserProfileCreate
    ) -> UserProfile:
        db_obj = UserProfile(**profile_in.model_dump(), user_id=user_id)
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj

    def create_score(
        self, db: Session, *, user_id: int, score_in: UserScoreCreate
    ) -> UserScore:
        db_obj = UserScore(**score_in.model_dump(), user_id=user_id)
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)
        return db_obj

    def update_score(
        self, db: Session, *, user_id: int, points: int
    ) -> UserScore:
        score = db.query(UserScore).filter(UserScore.user_id == user_id).first()
        if not score:
            score = UserScore(user_id=user_id, score=0)
            db.add(score)
        
        score.score += points
        # Update level based on score
        if score.score >= 1000:
            score.level = "trusted"
        elif score.score >= 500:
            score.level = "active"
        elif score.score >= 100:
            score.level = "verified"
        else:
            score.level = "novice"
        
        db.commit()
        db.refresh(score)
        return score


user = CRUDUser(User)
