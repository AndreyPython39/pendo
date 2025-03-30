from datetime import datetime
from sqlalchemy import Column, Integer, DateTime, ForeignKey, Boolean
from sqlalchemy.orm import relationship

from .base import Base

class Match(Base):
    __tablename__ = "matches"

    id = Column(Integer, primary_key=True)
    user1_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    user2_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    created_at = Column(DateTime(timezone=True), nullable=False, server_default='now()', index=True)
    is_active = Column(Boolean, nullable=False, server_default='true')

    # Relationships
    user1 = relationship("User", foreign_keys=[user1_id], back_populates="matches_as_user1")
    user2 = relationship("User", foreign_keys=[user2_id], back_populates="matches_as_user2")
    messages = relationship("Message", back_populates="match", cascade="all, delete-orphan")

    def __repr__(self):
        return f"<Match(user1_id={self.user1_id}, user2_id={self.user2_id})>"
