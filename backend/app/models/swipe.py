from datetime import datetime
from enum import Enum
from sqlalchemy import Column, Integer, DateTime, ForeignKey, Enum as SQLAlchemyEnum, String, CheckConstraint
from sqlalchemy.orm import relationship

from .base import Base

class SwipeAction(str, Enum):
    LIKE = 'like'
    DISLIKE = 'dislike'

class Swipe(Base):
    __tablename__ = "swipes"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete='CASCADE'), nullable=False)
    target_id = Column(Integer, ForeignKey("users.id", ondelete='CASCADE'), nullable=False)
    action = Column(SQLAlchemyEnum(SwipeAction), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)

    # Relationships
    user = relationship("User", foreign_keys=[user_id], back_populates="swipes_made")
    target = relationship("User", foreign_keys=[target_id], back_populates="swipes_received")

    def __repr__(self):
        return f"<Swipe(user_id={self.user_id}, target_id={self.target_id}, action={self.action})>"
