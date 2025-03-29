from datetime import datetime
from sqlalchemy import Column, String, Integer, DateTime, ForeignKey, JSON, Boolean
from sqlalchemy.orm import relationship

from .base import Base

class Story(Base):
    __tablename__ = "stories"

    id = Column(String, primary_key=True)
    user_id = Column(String, ForeignKey("users.id"))
    type = Column(String, nullable=False)  # image, video
    url = Column(String, nullable=False)
    caption = Column(String)
    cultural_tags = Column(JSON)
    view_count = Column(Integer, default=0)
    reaction_count = Column(Integer, default=0)
    created_at = Column(DateTime, default=datetime.utcnow)
    expires_at = Column(DateTime, nullable=False)

    # Relationships
    user = relationship("User", back_populates="stories")
    reactions = relationship("StoryReaction", back_populates="story")

class LiveStream(Base):
    __tablename__ = "live_streams"

    id = Column(String, primary_key=True)
    user_id = Column(String, ForeignKey("users.id"))
    title = Column(String, nullable=False)
    description = Column(String)
    stream_url = Column(String, nullable=False)
    thumbnail_url = Column(String)
    viewer_count = Column(Integer, default=0)
    cultural_tags = Column(JSON)
    is_active = Column(Boolean, default=True)
    started_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    user = relationship("User", back_populates="streams")
    comments = relationship("StreamComment", back_populates="stream")

class StoryReaction(Base):
    __tablename__ = "story_reactions"

    id = Column(String, primary_key=True)
    story_id = Column(String, ForeignKey("stories.id"))
    user_id = Column(String, ForeignKey("users.id"))
    type = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    story = relationship("Story", back_populates="reactions")

class StreamComment(Base):
    __tablename__ = "stream_comments"

    id = Column(String, primary_key=True)
    stream_id = Column(String, ForeignKey("live_streams.id"))
    user_id = Column(String, ForeignKey("users.id"))
    text = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    stream = relationship("LiveStream", back_populates="comments")
