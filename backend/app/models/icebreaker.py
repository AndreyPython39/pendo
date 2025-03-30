from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Boolean
from sqlalchemy.orm import relationship

from .base import Base

class IcebreakerQuestion(Base):
    __tablename__ = "icebreaker_questions"

    id = Column(Integer, primary_key=True)
    question = Column(String, nullable=False)
    category = Column(String, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default='now()', nullable=False)
    is_active = Column(Boolean, server_default='true', nullable=False)

    # Relationships
    answers = relationship("IcebreakerAnswer", back_populates="question")

    def __repr__(self):
        return f"<IcebreakerQuestion(id={self.id}, question={self.question})>"

class IcebreakerAnswer(Base):
    __tablename__ = "icebreaker_answers"

    id = Column(Integer, primary_key=True)
    question_id = Column(Integer, ForeignKey("icebreaker_questions.id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    answer = Column(String, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default='now()', nullable=False)

    # Relationships
    question = relationship("IcebreakerQuestion", back_populates="answers")
    user = relationship("User", back_populates="icebreaker_answers")

    def __repr__(self):
        return f"<IcebreakerAnswer(question_id={self.question_id}, user_id={self.user_id})>"
