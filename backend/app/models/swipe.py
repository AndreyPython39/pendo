from datetime import datetime
from sqlalchemy import Column, String, DateTime, ForeignKey, Enum
from sqlalchemy.orm import relationship
import enum

from .base import Base

class SwipeAction(enum.Enum):
    LIKE = "like"
    DISLIKE = "dislike"

class Swipe(Base):
    __tablename__ = "swipes"

    id = Column(String, primary_key=True)
    user_id = Column(String, ForeignKey("users.id"), nullable=False)
    target_id = Column(String, ForeignKey("users.id"), nullable=False)
    action = Column(Enum(SwipeAction), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    user = relationship("User", foreign_keys=[user_id])
    target = relationship("User", foreign_keys=[target_id])
