from datetime import datetime
from typing import Optional, List
from pydantic import BaseModel


class LiveStreamBase(BaseModel):
    title: str
    description: Optional[str] = None
    thumbnail_url: Optional[str] = None
    stream_url: str
    is_private: bool = False
    max_viewers: Optional[int] = None
    metadata: Optional[dict] = None


class LiveStreamCreate(LiveStreamBase):
    pass


class LiveStream(LiveStreamBase):
    id: str
    user_id: str
    current_viewers: int
    total_viewers: int
    started_at: datetime
    ended_at: Optional[datetime] = None
    duration: Optional[int] = None  # in seconds
    gifts_received: List[str] = []  # list of gift transaction IDs
    comments: List[str] = []  # list of comment IDs
    reactions: dict = {}  # reaction type to count mapping

    class Config:
        orm_mode = True


class StreamComment(BaseModel):
    id: str
    stream_id: str
    user_id: str
    content: str
    created_at: datetime

    class Config:
        orm_mode = True


class StreamReaction(BaseModel):
    id: str
    stream_id: str
    user_id: str
    reaction_type: str
    created_at: datetime

    class Config:
        orm_mode = True
