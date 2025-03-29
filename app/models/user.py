from typing import Optional
from sqlalchemy import Boolean, Column, Integer, String, DateTime, JSON, Float, ForeignKey, Date
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from geoalchemy2 import Geography
from app.db.base_class import Base


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=True)
    phone = Column(String, unique=True, index=True, nullable=True)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean(), default=True)
    is_superuser = Column(Boolean(), default=False)
    is_verified = Column(Boolean(), default=False)
    role = Column(String, default="user")
    location = Column(Geography(geometry_type='POINT', srid=4326), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False)
    
    # Profile relationship
    profile = relationship("UserProfile", back_populates="user", uselist=False)
    # Score relationship
    score = relationship("UserScore", back_populates="user", uselist=False)
    # Tribe relationships
    created_tribes = relationship("Tribe", back_populates="creator", foreign_keys="[Tribe.creator_id]")
    led_tribes = relationship("Tribe", back_populates="chief", foreign_keys="[Tribe.chief_id]")


class UserProfile(Base):
    __tablename__ = "user_profiles"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"), unique=True)
    birthdate = Column(Date, nullable=False)
    gender = Column(String, nullable=False)
    looking_for = Column(String, nullable=False)
    bio = Column(String, nullable=True)
    interests = Column(JSON, nullable=True)  # Array of interests
    temperament = Column(String, nullable=True)  # MBTI
    extra_data = Column(JSON, nullable=True, default={})
    moderation_status = Column(String, default="pending")
    moderated_by = Column(Integer, ForeignKey("users.id"), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False)

    # Relationships
    user = relationship("User", back_populates="profile", foreign_keys=[user_id])
    moderator = relationship("User", foreign_keys=[moderated_by])


class UserScore(Base):
    __tablename__ = "user_scores"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"), unique=True)
    score = Column(Integer, default=0)
    level = Column(String, default="novice")
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False)

    # Relationships
    user = relationship("User", back_populates="score")
