from datetime import datetime
from typing import Optional, List, Dict
from sqlalchemy import Column, Integer, String, Boolean, DateTime, Float, ForeignKey, JSON, Table
from sqlalchemy.orm import relationship
from geoalchemy2 import Geography

from .base import Base

# Таблица связи пользователей и интересов
user_interests = Table(
    'user_interests',
    Base.metadata,
    Column('user_profile_id', String, ForeignKey('user_profiles.id')),
    Column('interest_id', String, ForeignKey('interests.id'))
)

class Interest(Base):
    __tablename__ = "interests"

    id = Column(String, primary_key=True)
    name = Column(String, unique=True, index=True)
    category = Column(String, index=True)
    created_at = Column(DateTime, default=datetime.utcnow)

class User(Base):
    __tablename__ = "users"

    id = Column(String, primary_key=True)
    email = Column(String, unique=True, index=True)
    phone = Column(String, unique=True, index=True)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)
    is_verified = Column(Boolean, default=False)
    is_premium = Column(Boolean, default=False)
    last_active = Column(DateTime)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    profile = relationship("UserProfile", back_populates="user", uselist=False)
    score = relationship("UserScore", back_populates="user", uselist=False)
    current_tribe = relationship("Tribe", back_populates="members")
    stories = relationship("Story", back_populates="user")
    streams = relationship("LiveStream", back_populates="user")
    gifts_sent = relationship("GiftTransaction", foreign_keys="[GiftTransaction.sender_id]")
    gifts_received = relationship("GiftTransaction", foreign_keys="[GiftTransaction.receiver_id]")

class UserProfile(Base):
    __tablename__ = "user_profiles"

    id = Column(String, primary_key=True)
    user_id = Column(String, ForeignKey("users.id"), unique=True)
    name = Column(String, nullable=False)
    birthdate = Column(DateTime, nullable=False)
    gender = Column(String, nullable=False)
    looking_for = Column(String, nullable=False)
    bio = Column(String)
    location = Column(Geography(geometry_type='POINT', srid=4326))
    distance = Column(Float)  # Distance from search point in km
    temperament = Column(String)  # MBTI
    extra_data = Column(JSON)
    profile_photos = Column(JSON)  # List of photo URLs
    pendo_score = Column(Integer, default=0)
    current_tribe_id = Column(String, ForeignKey("tribes.id"))
    cultural_preferences = Column(JSON)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    user = relationship("User", back_populates="profile")
    interests = relationship("Interest", secondary=user_interests)

class UserScore(Base):
    __tablename__ = "user_scores"

    id = Column(String, primary_key=True)
    user_id = Column(String, ForeignKey("users.id"), unique=True)
    score = Column(Integer, default=0)
    level = Column(String, default="novice")  # novice, verified, active, trusted
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    user = relationship("User", back_populates="score")
