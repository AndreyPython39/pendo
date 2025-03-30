from datetime import datetime
from pydantic import BaseModel, constr
from typing import Optional, Literal

SwipeAction = Literal['like', 'pass', 'superlike']

class SwipeBase(BaseModel):
    target_id: int
    action: SwipeAction

class SwipeCreate(SwipeBase):
    pass

class SwipeResponse(SwipeBase):
    id: int
    user_id: int
    created_at: datetime

    class Config:
        orm_mode = True

class SwipeMatch(BaseModel):
    is_match: bool
    match_id: Optional[int] = None
    target_user: Optional[dict] = None  # Упрощенная информация о пользователе

    class Config:
        orm_mode = True
