from datetime import datetime
from sqlalchemy import Column, String, Integer, DateTime, ForeignKey, Boolean, Enum as SQLAlchemyEnum
from sqlalchemy.orm import relationship

from .base import Base
from .types import GiftType

class VirtualGift(Base):
    __tablename__ = "virtual_gifts"

    id = Column(String, primary_key=True)
    name = Column(String, nullable=False)
    description = Column(String)
    image_url = Column(String, nullable=False)
    animation_url = Column(String)
    price = Column(Integer, nullable=False)
    cultural_significance = Column(String)
    cultural_category = Column(String)
    is_premium = Column(Boolean, default=False)

class GiftTransaction(Base):
    __tablename__ = "gift_transactions"

    id = Column(String, primary_key=True)
    gift_id = Column(String, ForeignKey("virtual_gifts.id"))
    sender_id = Column(String, ForeignKey("users.id"))
    receiver_id = Column(String, ForeignKey("users.id"))
    message = Column(String)
    price = Column(Integer, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

class GiftCollection(Base):
    __tablename__ = "gift_collections"

    id = Column(String, primary_key=True)
    user_id = Column(String, ForeignKey("users.id"))
    gift_id = Column(String, ForeignKey("virtual_gifts.id"))
    count = Column(Integer, default=0)
    first_received = Column(DateTime, nullable=False)
    last_received = Column(DateTime, nullable=False)

class Gift(Base):
    __tablename__ = "gifts"

    id = Column(Integer, primary_key=True, index=True)
    from_id = Column(Integer, ForeignKey("users.id", ondelete='CASCADE'), nullable=False)
    to_id = Column(Integer, ForeignKey("users.id", ondelete='CASCADE'), nullable=False)
    gift_type = Column(SQLAlchemyEnum(GiftType), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)

    # Relationships
    sender = relationship("User", foreign_keys=[from_id], back_populates="gifts_sent")
    receiver = relationship("User", foreign_keys=[to_id], back_populates="gifts_received")

    def __repr__(self):
        return f"<Gift(from_id={self.from_id}, to_id={self.to_id}, type={self.gift_type})>"
