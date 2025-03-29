from typing import Optional, List
from datetime import datetime
from pydantic import BaseModel


class MatchBase(BaseModel):
    user1_id: int
    user2_id: int
    is_active: bool = True


class MatchCreate(MatchBase):
    pass


class MatchUpdate(MatchBase):
    is_active: Optional[bool] = None


class MatchInDBBase(MatchBase):
    id: int
    matched_at: datetime
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class Match(MatchInDBBase):
    pass


# Like schemas
class LikeBase(BaseModel):
    from_user_id: int
    to_user_id: int
    is_super_like: bool = False


class LikeCreate(LikeBase):
    pass


class LikeUpdate(LikeBase):
    is_super_like: Optional[bool] = None


class LikeInDBBase(LikeBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class Like(LikeInDBBase):
    pass


# Message schemas
class MessageBase(BaseModel):
    match_id: int
    sender_id: int
    content: str
    is_read: bool = False


class MessageCreate(MessageBase):
    pass


class MessageUpdate(MessageBase):
    content: Optional[str] = None
    is_read: Optional[bool] = None


class MessageInDBBase(MessageBase):
    id: int
    sent_at: datetime
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class Message(MessageInDBBase):
    pass


# Response schemas for API
class MatchWithMessages(Match):
    messages: List[Message] = []
