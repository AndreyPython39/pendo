from sqlalchemy import Column, Integer, String, JSON, DateTime, ForeignKey, Enum as SQLEnum
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
import enum

from app.db.base_class import Base


class TribeStatus(enum.Enum):
    pending = "pending"
    active = "active"
    archived = "archived"


class Tribe(Base):
    __tablename__ = "tribes"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    description = Column(String, nullable=True)
    image_url = Column(String, nullable=True)
    creator_id = Column(Integer, ForeignKey("users.id"))
    chief_id = Column(Integer, ForeignKey("users.id"), nullable=True)
    status = Column(SQLEnum(TribeStatus), default=TribeStatus.pending)
    extra_data = Column(JSON, nullable=True)
    moderation_status = Column(String, default="pending")
    moderated_by = Column(Integer, ForeignKey("users.id"), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False)

    # Relationships
    creator = relationship("User", foreign_keys=[creator_id], back_populates="created_tribes")
    chief = relationship("User", foreign_keys=[chief_id], back_populates="led_tribes")
    moderator = relationship("User", foreign_keys=[moderated_by])
    members = relationship("TribeMember", back_populates="tribe")
    votes = relationship("TribeVote", back_populates="tribe")


class TribeMember(Base):
    __tablename__ = "tribe_members"

    id = Column(Integer, primary_key=True)
    tribe_id = Column(Integer, ForeignKey("tribes.id"))
    user_id = Column(Integer, ForeignKey("users.id"))
    joined_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)

    # Relationships
    tribe = relationship("Tribe", back_populates="members")
    user = relationship("User")


class TribeVote(Base):
    __tablename__ = "tribe_votes"

    id = Column(Integer, primary_key=True)
    tribe_id = Column(Integer, ForeignKey("tribes.id"))
    voter_id = Column(Integer, ForeignKey("users.id"))
    candidate_id = Column(Integer, ForeignKey("users.id"))
    voted_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)

    # Relationships
    tribe = relationship("Tribe", back_populates="votes")
    voter = relationship("User", foreign_keys=[voter_id])
    candidate = relationship("User", foreign_keys=[candidate_id])
