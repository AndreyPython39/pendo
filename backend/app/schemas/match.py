from datetime import datetime
from pydantic import BaseModel
from typing import Optional, List
from .user import UserBasic

class MatchBase(BaseModel):
    user1_id: int
    user2_id: int

class MatchCreate(MatchBase):
    pass

class Match(MatchBase):
    id: int
    created_at: datetime
    is_active: bool
    user1: Optional[UserBasic]
    user2: Optional[UserBasic]

    class Config:
        orm_mode = True

class MatchList(BaseModel):
    matches: List[Match]
    total: int
