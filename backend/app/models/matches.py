from datetime import datetime
from sqlalchemy import Column, String, DateTime, ForeignKey, Boolean, Integer
from sqlalchemy.orm import relationship

from .base import Base

class Swipe(Base):
    __tablename__ = "swipes"

    id = Column(String, primary_key=True)
    from_user_id = Column(String, ForeignKey("users.id"))
    to_user_id = Column(String, ForeignKey("users.id"))
    action = Column(String, nullable=False)  # like, dislike
    created_at = Column(DateTime, default=datetime.utcnow)

class Match(Base):
    __tablename__ = "matches"

    id = Column(String, primary_key=True)
    user1_id = Column(String, ForeignKey("users.id"))
    user2_id = Column(String, ForeignKey("users.id"))
    status = Column(String, default="active")  # active, archived
    created_at = Column(DateTime, default=datetime.utcnow)
    last_message_at = Column(DateTime)

    # Relationships
    messages = relationship("Message", back_populates="match")
    icebreaker_answers = relationship("IcebreakerAnswer", back_populates="match")

class Message(Base):
    __tablename__ = "messages"

    id = Column(String, primary_key=True)
    match_id = Column(String, ForeignKey("matches.id"))
    sender_id = Column(String, ForeignKey("users.id"))
    content = Column(String, nullable=False)
    content_type = Column(String, default="text")  # text, image, gift
    is_read = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    match = relationship("Match", back_populates="messages")

class IcebreakerQuestion(Base):
    __tablename__ = "icebreaker_questions"

    id = Column(String, primary_key=True)
    question = Column(String, nullable=False)
    cultural_category = Column(String)
    difficulty = Column(Integer, default=1)
    created_at = Column(DateTime, default=datetime.utcnow)

class IcebreakerAnswer(Base):
    __tablename__ = "icebreaker_answers"

    id = Column(String, primary_key=True)
    match_id = Column(String, ForeignKey("matches.id"))
    question_id = Column(String, ForeignKey("icebreaker_questions.id"))
    user_id = Column(String, ForeignKey("users.id"))
    answer = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    match = relationship("Match", back_populates="icebreaker_answers")
