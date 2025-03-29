from typing import Optional, Dict, Any
from datetime import datetime
from pydantic import BaseModel, EmailStr, Field
from shapely.geometry import Point


class UserBase(BaseModel):
    email: Optional[EmailStr] = None
    phone: Optional[str] = None
    is_active: Optional[bool] = True
    is_superuser: bool = False
    is_verified: Optional[bool] = False
    role: Optional[str] = "user"


class UserLocation(BaseModel):
    latitude: float = Field(..., ge=-90, le=90)
    longitude: float = Field(..., ge=-180, le=180)

    def to_point(self) -> Point:
        return Point(self.longitude, self.latitude)


class UserCreate(UserBase):
    email: Optional[EmailStr] = None
    phone: Optional[str] = None
    password: str
    location: Optional[UserLocation] = None

    @property
    def has_contact(self) -> bool:
        return bool(self.email or self.phone)


class UserUpdate(UserBase):
    password: Optional[str] = None
    location: Optional[UserLocation] = None


class UserInDBBase(UserBase):
    id: Optional[int] = None
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class User(UserInDBBase):
    pass


class UserInDB(UserInDBBase):
    hashed_password: str


# Profile schemas
class UserProfileBase(BaseModel):
    birthdate: datetime
    gender: str
    looking_for: str
    bio: Optional[str] = None
    interests: Optional[list[str]] = None
    temperament: Optional[str] = None  # MBTI
    extra_data: Optional[Dict[str, Any]] = None
    moderation_status: Optional[str] = "pending"


class UserProfileCreate(UserProfileBase):
    pass


class UserProfileUpdate(UserProfileBase):
    birthdate: Optional[datetime] = None
    gender: Optional[str] = None
    looking_for: Optional[str] = None


class UserProfileInDBBase(UserProfileBase):
    id: int
    user_id: int
    moderated_by: Optional[int] = None
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class UserProfile(UserProfileInDBBase):
    pass


# Score schemas
class UserScoreBase(BaseModel):
    score: int = 0
    level: str = "novice"


class UserScoreCreate(UserScoreBase):
    user_id: int


class UserScoreUpdate(UserScoreBase):
    score: Optional[int] = None
    level: Optional[str] = None


class UserScoreInDBBase(UserScoreBase):
    id: int
    user_id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class UserScore(UserScoreInDBBase):
    pass
