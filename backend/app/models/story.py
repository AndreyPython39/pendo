from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, JSON, Boolean, CheckConstraint
from sqlalchemy.orm import relationship

from .base import Base

class Story(Base):
    __tablename__ = "stories"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    media_url = Column(String, nullable=False)
    thumbnail_url = Column(String, nullable=True)
    media_type = Column(String, nullable=False)
    caption = Column(String, nullable=True)
    views_count = Column(Integer, server_default='0', nullable=False)
    created_at = Column(DateTime(timezone=True), server_default='now()', nullable=False, index=True)
    expires_at = Column(DateTime(timezone=True), nullable=False, index=True)

    # Relationships
    user = relationship("User", back_populates="stories")
    views = relationship("StoryView", back_populates="story", cascade="all, delete-orphan")

    # Constraints
    __table_args__ = (
        CheckConstraint(
            "media_type IN ('image', 'video')",
            name='valid_story_media_type'
        ),
    )

    def __repr__(self):
        return f"<Story(id={self.id}, user_id={self.user_id}, media_type={self.media_type})>"

class StoryView(Base):
    __tablename__ = "story_views"

    id = Column(Integer, primary_key=True)
    story_id = Column(Integer, ForeignKey("stories.id"), nullable=False, index=True)
    viewer_id = Column(Integer, ForeignKey("users.id"), nullable=False, index=True)
    viewed_at = Column(DateTime(timezone=True), server_default='now()', nullable=False)

    # Relationships
    story = relationship("Story", back_populates="views")
    viewer = relationship("User", back_populates="story_views")

    def __repr__(self):
        return f"<StoryView(story_id={self.story_id}, viewer_id={self.viewer_id})>"

class LiveStream(Base):
    __tablename__ = "live_streams"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    title = Column(String, nullable=False)
    description = Column(String)
    stream_url = Column(String, nullable=False)
    thumbnail_url = Column(String)
    viewer_count = Column(Integer, default=0)
    cultural_tags = Column(JSON)
    is_active = Column(Boolean, default=True)
    started_at = Column(DateTime(timezone=True), server_default='now()', nullable=False)

    # Relationships
    user = relationship("User", back_populates="streams")
    comments = relationship("StreamComment", back_populates="stream", cascade="all, delete-orphan")

    def __repr__(self):
        return f"<LiveStream(id={self.id}, user_id={self.user_id}, title={self.title})>"

class StreamComment(Base):
    __tablename__ = "stream_comments"

    id = Column(Integer, primary_key=True)
    stream_id = Column(Integer, ForeignKey("live_streams.id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    text = Column(String, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default='now()', nullable=False)

    # Relationships
    stream = relationship("LiveStream", back_populates="comments")
    user = relationship("User", back_populates="stream_comments")

    def __repr__(self):
        return f"<StreamComment(stream_id={self.stream_id}, user_id={self.user_id})>"
