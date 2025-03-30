from datetime import datetime
from pydantic import BaseModel, HttpUrl
from typing import Optional, List, Literal

MediaType = Literal['image', 'video', 'audio', 'file']

class MessageBase(BaseModel):
    content: str
    media_url: Optional[HttpUrl] = None
    media_type: Optional[MediaType] = None

class MessageCreate(MessageBase):
    match_id: int

class Message(MessageBase):
    id: int
    match_id: int
    sender_id: int
    is_read: bool
    created_at: datetime

    class Config:
        orm_mode = True

class MessageList(BaseModel):
    messages: List[Message]
    total: int
    unread_count: int
