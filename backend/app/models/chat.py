from datetime import datetime
from sqlalchemy import Column, Integer, DateTime, ForeignKey, Enum as SQLAlchemyEnum
from sqlalchemy.orm import relationship

from .base import Base
from .types import ChatStatus

class Match(Base):
    __tablename__ = "matches"

    id = Column(Integer, primary_key=True, index=True)
    user1_id = Column(Integer, ForeignKey("users.id", ondelete='CASCADE'), nullable=False)
    user2_id = Column(Integer, ForeignKey("users.id", ondelete='CASCADE'), nullable=False)
    status = Column(SQLAlchemyEnum(ChatStatus), default=ChatStatus.ACTIVE, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)

    # Relationships
    user1 = relationship("User", foreign_keys=[user1_id])
    user2 = relationship("User", foreign_keys=[user2_id])
    messages = relationship("Message", back_populates="match", cascade="all, delete-orphan")

    def __repr__(self):
        return f"<Match(id={self.id}, user1_id={self.user1_id}, user2_id={self.user2_id}, status={self.status})>"

class Message(Base):
    __tablename__ = "messages"

    id = Column(Integer, primary_key=True, index=True)
    match_id = Column(Integer, ForeignKey("matches.id", ondelete='CASCADE'), nullable=False)
    sender_id = Column(Integer, ForeignKey("users.id", ondelete='CASCADE'), nullable=False)
    content = Column(String, nullable=False)
    is_read = Column(Boolean, default=False, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)

    # Relationships
    match = relationship("Match", back_populates="messages")
    sender = relationship("User", foreign_keys=[sender_id])

    def __repr__(self):
        return f"<Message(match_id={self.match_id}, sender_id={self.sender_id}, is_read={self.is_read})>"
