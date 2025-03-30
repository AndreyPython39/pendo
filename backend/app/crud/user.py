from typing import Optional, List, Dict
from sqlalchemy.orm import Session
from sqlalchemy import func
from geoalchemy2 import Geography
from datetime import datetime

from app.models.user import User, UserProfile
from app.schemas.user import UserCreate, UserUpdate
from app.core.security import get_password_hash
from app.core.config import settings

class UserCRUD:
    def get(self, db: Session, user_id: str) -> Optional[User]:
        return db.query(User).filter(User.id == user_id).first()

    def get_by_email(self, db: Session, email: str) -> Optional[User]:
        return db.query(User).filter(User.email == email).first()

    def create(self, db: Session, user_create: UserCreate) -> User:
        db_user = User(
            email=user_create.email,
            phone=user_create.phone,
            hashed_password=get_password_hash(user_create.password),
            is_active=True
        )
        db.add(db_user)
        db.flush()

        # Create user profile
        db_profile = UserProfile(
            user_id=db_user.id,
            name=user_create.name,
            birthdate=user_create.birthdate,
            gender=user_create.gender,
            looking_for=user_create.looking_for,
            bio=user_create.bio,
            interests=user_create.interests,
            temperament=user_create.temperament,
            extra_data=user_create.extra_data,
            profile_photos=user_create.profile_photos
        )
        db.add(db_profile)
        db.commit()
        db.refresh(db_user)
        return db_user

    def update_user(self, db: Session, user_id: str, user_update: UserUpdate) -> User:
        db_user = self.get(db, user_id)
        if not db_user:
            return None
            
        # Update profile fields
        for field, value in user_update.dict(exclude_unset=True).items():
            if hasattr(db_user.profile, field):
                setattr(db_user.profile, field, value)
        
        db_user.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(db_user)
        return db_user

    def update_location(self, db: Session, user_id: str, lat: float, lon: float) -> User:
        db_user = self.get(db, user_id)
        if not db_user:
            return None
            
        point = f'POINT({lon} {lat})'
        db_user.profile.location = point
        db_user.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(db_user)
        return db_user

    def get_nearby_users(
        self, 
        db: Session, 
        lat: float, 
        lon: float, 
        radius_km: float = 10, 
        limit: int = 20
    ) -> List[User]:
        point = func.ST_SetSRID(func.ST_MakePoint(lon, lat), 4326)
        query = db.query(User).join(UserProfile)
        query = query.filter(
            func.ST_DWithin(
                UserProfile.location,
                point,
                radius_km * 1000  # Convert km to meters
            )
        )
        query = query.order_by(
            func.ST_Distance(UserProfile.location, point)
        )
        return query.limit(limit).all()

user_crud = UserCRUD()
