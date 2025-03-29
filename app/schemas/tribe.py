from typing import Optional, Dict, Any
from datetime import datetime
from enum import Enum
from pydantic import BaseModel


class TribeStatus(str, Enum):
    pending = "pending"
    active = "active"
    archived = "archived"


class TribeBase(BaseModel):
    name: str
    description: Optional[str] = None
    image_url: Optional[str] = None
    status: TribeStatus = TribeStatus.pending
    moderation_status: Optional[str] = "pending"
    extra_data: Optional[Dict[str, Any]] = None


class TribeCreate(TribeBase):
    creator_id: int


class TribeUpdate(TribeBase):
    name: Optional[str] = None
    description: Optional[str] = None
    image_url: Optional[str] = None
    status: Optional[TribeStatus] = None
    moderation_status: Optional[str] = None


class TribeInDBBase(TribeBase):
    id: int
    creator_id: int
    chief_id: Optional[int] = None
    moderated_by: Optional[int] = None
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class Tribe(TribeInDBBase):
    pass


# Member schemas
class TribeMemberBase(BaseModel):
    tribe_id: int
    user_id: int


class TribeMemberCreate(TribeMemberBase):
    pass


class TribeMemberUpdate(TribeMemberBase):
    pass


class TribeMemberInDBBase(TribeMemberBase):
    id: int
    joined_at: datetime

    class Config:
        from_attributes = True


class TribeMember(TribeMemberInDBBase):
    pass


# Vote schemas
class TribeVoteBase(BaseModel):
    tribe_id: int
    voter_id: int
    candidate_id: int


class TribeVoteCreate(TribeVoteBase):
    pass


class TribeVoteUpdate(TribeVoteBase):
    pass


class TribeVoteInDBBase(TribeVoteBase):
    id: int
    voted_at: datetime

    class Config:
        from_attributes = True


class TribeVote(TribeVoteInDBBase):
    pass
