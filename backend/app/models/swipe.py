from datetime import datetime
from sqlalchemy import Column, Integer, DateTime, ForeignKey, String, CheckConstraint
from sqlalchemy.orm import relationship

from .base import Base

class Swipe(Base):
    __tablename__ = "swipes"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    target_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    action = Column(String, nullable=False)
    created_at = Column(DateTime(timezone=True), nullable=False, server_default='now()', index=True)

    # Relationships
    user = relationship("User", foreign_keys=[user_id], back_populates="swipes_made")
    target = relationship("User", foreign_keys=[target_id], back_populates="swipes_received")

    # Constraints
    __table_args__ = (
        CheckConstraint(
            "action IN ('like', 'pass', 'superlike')",
            name='valid_swipe_action'
        ),
    )

    def __repr__(self):
        return f"<Swipe(user_id={self.user_id}, target_id={self.target_id}, action={self.action})>"
