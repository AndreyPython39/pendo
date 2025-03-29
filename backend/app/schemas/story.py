from pydantic import BaseModel
from datetime import datetime
from typing import Optional, List

class StoryBase(BaseModel):
    media_type: str
    media_url: str
    thumbnail_url: Optional[str] = None
    caption: Optional[str] = None

class StoryCreate(StoryBase):
    pass

class StoryResponse(StoryBase):
    id: int
    user_id: int
    views_count: int
    expires_at: datetime
    created_at: datetime
    is_viewed: bool = False

    class Config:
        orm_mode = True

class StoryList(BaseModel):
    stories: List[StoryResponse]
