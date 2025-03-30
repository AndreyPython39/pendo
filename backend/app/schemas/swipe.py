from datetime import datetime
from pydantic import BaseModel
from typing import Optional
from app.models.swipe import SwipeAction

class SwipeBase(BaseModel):
    target_id: str
    action: SwipeAction

class SwipeCreate(SwipeBase):
    pass

class SwipeResponse(SwipeBase):
    id: str
    user_id: str
    created_at: datetime

    class Config:
        orm_mode = True
