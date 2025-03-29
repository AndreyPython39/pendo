from typing import Optional, Dict, Any
from datetime import datetime
from enum import Enum
from pydantic import BaseModel


class ModerationAction(str, Enum):
    approve = "approve"
    reject = "reject"
    block = "block"
    unblock = "unblock"
    warn = "warn"


class ModerationObject(str, Enum):
    user = "user"
    profile = "profile"
    tribe = "tribe"
    message = "message"
    photo = "photo"


class ModerationLogBase(BaseModel):
    object_type: ModerationObject
    object_id: int
    action: ModerationAction
    reason: Optional[str] = None
    extra_data: Optional[Dict[str, Any]] = None


class ModerationLogCreate(ModerationLogBase):
    moderator_id: int


class ModerationLogUpdate(ModerationLogBase):
    pass


class ModerationLogInDBBase(ModerationLogBase):
    id: int
    moderator_id: int
    created_at: datetime

    class Config:
        from_attributes = True


class ModerationLog(ModerationLogInDBBase):
    pass


# Photo schemas
class PhotoBase(BaseModel):
    url: str
    is_primary: bool = False
    moderation_status: str = "pending"


class PhotoCreate(PhotoBase):
    user_id: int


class PhotoUpdate(PhotoBase):
    url: Optional[str] = None
    is_primary: Optional[bool] = None
    moderation_status: Optional[str] = None


class PhotoInDBBase(PhotoBase):
    id: int
    user_id: int
    moderated_by: Optional[int] = None
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class Photo(PhotoInDBBase):
    pass
