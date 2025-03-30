from datetime import datetime
from pydantic import BaseModel
from typing import Optional, List

class MessageBase(BaseModel):
    match_id: str
    content: str

class MessageCreate(MessageBase):
    pass

class MessageResponse(MessageBase):
    id: str
    sender_id: str
    is_read: bool
    created_at: datetime

    class Config:
        orm_mode = True

class MatchBase(BaseModel):
    user1_id: str
    user2_id: str

class MatchCreate(MatchBase):
    pass

class MatchResponse(MatchBase):
    id: str
    created_at: datetime
    is_active: bool
    messages: List[MessageResponse] = []

    class Config:
        orm_mode = True
