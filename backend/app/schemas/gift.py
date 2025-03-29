from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class GiftBase(BaseModel):
    name: str
    description: Optional[str] = None
    image_url: str
    animation_url: Optional[str] = None
    coins: int
    is_animated: bool = False
    is_premium: bool = False
    is_limited: bool = False
    available_until: Optional[datetime] = None
    metadata: Optional[dict] = None


class GiftCreate(GiftBase):
    pass


class Gift(GiftBase):
    id: str
    created_at: datetime

    class Config:
        orm_mode = True


class GiftTransactionBase(BaseModel):
    sender_id: str
    receiver_id: str
    gift_id: str
    coins: int
    message: Optional[str] = None
    is_anonymous: bool = False


class GiftTransactionCreate(GiftTransactionBase):
    pass


class GiftTransaction(GiftTransactionBase):
    id: str
    sent_at: datetime

    class Config:
        orm_mode = True
