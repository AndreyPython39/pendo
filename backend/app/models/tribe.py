from datetime import datetime
from sqlalchemy import Column, String, Integer, DateTime, ForeignKey, JSON, Boolean
from sqlalchemy.orm import relationship
from geoalchemy2 import Geography

from .base import Base

class Tribe(Base):
    __tablename__ = "tribes"

    id = Column(String, primary_key=True)
    name = Column(String, nullable=False)
    description = Column(String)
    image_url = Column(String)
    created_by = Column(String, ForeignKey("users.id"))
    status = Column(String, default="pending")  # pending, active, archived
    location = Column(Geography(geometry_type='POINT', srid=4326))
    cultural_focus = Column(JSON)  # List of cultural aspects
    traditions = Column(JSON)  # List of traditions
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    members = relationship("User", back_populates="current_tribe")
    events = relationship("TribeEvent", back_populates="tribe")
    votes = relationship("TribeVote", back_populates="tribe")

class TribeEvent(Base):
    __tablename__ = "tribe_events"

    id = Column(String, primary_key=True)
    tribe_id = Column(String, ForeignKey("tribes.id"))
    title = Column(String, nullable=False)
    description = Column(String)
    date = Column(DateTime, nullable=False)
    location = Column(String, nullable=False)
    image_url = Column(String)
    created_by = Column(String, ForeignKey("users.id"))
    attendees_count = Column(Integer, default=0)
    cultural_type = Column(String)
    traditions = Column(JSON)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    tribe = relationship("Tribe", back_populates="events")
    attendees = relationship("EventAttendee", back_populates="event")

class TribeVote(Base):
    __tablename__ = "tribe_votes"

    id = Column(String, primary_key=True)
    tribe_id = Column(String, ForeignKey("tribes.id"))
    title = Column(String, nullable=False)
    description = Column(String)
    created_by = Column(String, ForeignKey("users.id"))
    ends_at = Column(DateTime, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    tribe = relationship("Tribe", back_populates="votes")
    options = relationship("VoteOption", back_populates="vote")

class VoteOption(Base):
    __tablename__ = "vote_options"

    id = Column(String, primary_key=True)
    vote_id = Column(String, ForeignKey("tribe_votes.id"))
    text = Column(String, nullable=False)
    votes_count = Column(Integer, default=0)

    # Relationships
    vote = relationship("TribeVote", back_populates="options")
