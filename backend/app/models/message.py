from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Boolean, CheckConstraint
from sqlalchemy.orm import relationship

from .base import Base

class Message(Base):
    __tablename__ = "messages"

    id = Column(Integer, primary_key=True)
    match_id = Column(Integer, ForeignKey("matches.id"), nullable=False, index=True)
    sender_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    content = Column(String, nullable=False)
    media_url = Column(String, nullable=True)
    media_type = Column(String, nullable=True)
    is_read = Column(Boolean, nullable=False, server_default='false')
    created_at = Column(DateTime(timezone=True), nullable=False, server_default='now()', index=True)

    # Relationships
    match = relationship("Match", back_populates="messages")
    sender = relationship("User", back_populates="sent_messages")

    # Constraints
    __table_args__ = (
        CheckConstraint(
            "media_type IN ('image', 'video', 'audio', 'file')",
            name='valid_media_type'
        ),
    )

    def __repr__(self):
        return f"<Message(match_id={self.match_id}, sender_id={self.sender_id})>"
