from datetime import datetime
from sqlalchemy import Column, String, Integer, DateTime, ForeignKey, JSON, Boolean
from sqlalchemy.orm import relationship
from geoalchemy2 import Geography

from .base import Base

class CulturalEvent(Base):
    __tablename__ = "cultural_events"

    id = Column(String, primary_key=True)
    title = Column(String, nullable=False)
    description = Column(String)
    event_type = Column(String, nullable=False)
    date = Column(DateTime, nullable=False)
    location = Column(Geography(geometry_type='POINT', srid=4326))
    image_url = Column(String)
    created_by = Column(String, ForeignKey("users.id"))
    attendees_count = Column(Integer, default=0)
    max_attendees = Column(Integer)
    cultural_significance = Column(String)
    traditions = Column(JSON)
    required_dress_code = Column(String)
    food_preferences = Column(JSON)
    is_private = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    attendees = relationship("EventAttendee", back_populates="event")
    comments = relationship("EventComment", back_populates="event")
    photos = relationship("EventPhoto", back_populates="event")

class EventAttendee(Base):
    __tablename__ = "event_attendees"

    id = Column(String, primary_key=True)
    event_id = Column(String, ForeignKey("cultural_events.id"))
    user_id = Column(String, ForeignKey("users.id"))
    status = Column(String, nullable=False)  # going, maybe, not_going
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    event = relationship("CulturalEvent", back_populates="attendees")

class EventComment(Base):
    __tablename__ = "event_comments"

    id = Column(String, primary_key=True)
    event_id = Column(String, ForeignKey("cultural_events.id"))
    user_id = Column(String, ForeignKey("users.id"))
    text = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    event = relationship("CulturalEvent", back_populates="comments")

class EventPhoto(Base):
    __tablename__ = "event_photos"

    id = Column(String, primary_key=True)
    event_id = Column(String, ForeignKey("cultural_events.id"))
    user_id = Column(String, ForeignKey("users.id"))
    photo_url = Column(String, nullable=False)
    caption = Column(String)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    event = relationship("CulturalEvent", back_populates="photos")
