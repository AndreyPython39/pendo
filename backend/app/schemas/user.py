from datetime import datetime
from typing import Optional, List, Dict
from pydantic import BaseModel, EmailStr, constr, validator
from .location import Location
from .gift import GiftTransaction
from .stream import LiveStream


class UserBase(BaseModel):
    email: Optional[EmailStr] = None
    phone: Optional[str] = None
    name: str
    birthdate: datetime
    gender: str
    looking_for: str
    bio: Optional[str] = None
    interests: Optional[List[str]] = None
    temperament: Optional[str] = None  # MBTI
    extra_data: Optional[Dict] = None
    pendo_score: Optional[int] = None
    is_verified: Optional[bool] = None
    is_premium: Optional[bool] = None
    is_active: Optional[bool] = True
    current_tribe_id: Optional[str] = None
    profile_photos: Optional[List[str]] = None
    location: Optional[Location] = None
    last_active: Optional[datetime] = None
    gifts_sent: Optional[List[GiftTransaction]] = None
    gifts_received: Optional[List[GiftTransaction]] = None
    streams: Optional[List[LiveStream]] = None


class UserCreate(UserBase):
    password: constr(min_length=8)
    email: EmailStr

    @validator('password')
    def password_strength(cls, v):
        if not any(c.isupper() for c in v):
            raise ValueError('Password must contain at least one uppercase letter')
        if not any(c.islower() for c in v):
            raise ValueError('Password must contain at least one lowercase letter')
        if not any(c.isdigit() for c in v):
            raise ValueError('Password must contain at least one number')
        return v


class UserUpdate(BaseModel):
    name: Optional[str] = None
    bio: Optional[str] = None
    interests: Optional[List[str]] = None
    temperament: Optional[str] = None
    extra_data: Optional[Dict] = None
    profile_photos: Optional[List[str]] = None
    location: Optional[Location] = None


class UserInDB(UserBase):
    id: str
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True


class UserProfile(BaseModel):
    user_id: str
    name: str
    age: int
    gender: str
    looking_for: str
    bio: Optional[str] = None
    interests: Optional[List[str]] = None
    temperament: Optional[str] = None
    extra_data: Optional[Dict] = None
    profile_photos: Optional[List[str]] = None
    pendo_score: Optional[int] = None
    is_verified: Optional[bool] = None
    is_premium: Optional[bool] = None
    location: Optional[Location] = None
    distance: Optional[float] = None
    last_active: Optional[datetime] = None
    cultural_preferences: Optional[Dict] = None

    class Config:
        orm_mode = True


class UserScore(BaseModel):
    user_id: str
    score: int
    level: str
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True


class Token(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"


class TokenPayload(BaseModel):
    sub: str
    exp: int
    type: str
