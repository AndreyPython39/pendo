from pydantic import BaseModel, EmailStr, validator, Field
from datetime import date, datetime
from typing import Optional, List
from enum import Enum

class Gender(str, Enum):
    MALE = "male"
    FEMALE = "female"
    NON_BINARY = "non_binary"
    OTHER = "other"

class LookingFor(str, Enum):
    MEN = "men"
    WOMEN = "women"
    EVERYONE = "everyone"

class AuthBase(BaseModel):
    email: EmailStr

class RequestCode(AuthBase):
    pass

class VerifyCode(AuthBase):
    code: str = Field(..., min_length=6, max_length=6)

class Register(AuthBase):
    code: str = Field(..., min_length=6, max_length=6)
    name: str = Field(..., min_length=2, max_length=50)
    birthdate: date
    gender: Gender
    looking_for: LookingFor
    bio: Optional[str] = Field(None, max_length=500)
    interests: List[str] = []
    location_lat: Optional[float] = None
    location_lon: Optional[float] = None

    @validator('birthdate')
    def validate_age(cls, v):
        today = date.today()
        age = today.year - v.year - ((today.month, today.day) < (v.month, v.day))
        if age < 18:
            raise ValueError('You must be at least 18 years old to register')
        return v

class Login(AuthBase):
    pass

class VerifyLogin(AuthBase):
    code: str = Field(..., min_length=6, max_length=6)

class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in: int

class UserResponse(BaseModel):
    id: int
    email: str
    name: str
    birthdate: date
    gender: Gender
    looking_for: LookingFor
    bio: Optional[str]
    avatar_url: Optional[str]
    pendo_score: int
    is_verified: bool
    is_premium: bool
    created_at: datetime

    class Config:
        orm_mode = True

class AuthResponse(BaseModel):
    user: UserResponse
    token: TokenResponse

    class Config:
        orm_mode = True
