from datetime import datetime
from typing import Optional, List, Dict
from sqlalchemy import Column, Integer, String, Boolean, DateTime, Float, ForeignKey, JSON, Table, Date, Numeric, Text, CheckConstraint
from sqlalchemy.orm import relationship
from geoalchemy2 import Geography

from .base import Base
from .types import Gender

# Таблица связи пользователей и интересов
user_interests = Table(
    'user_interests',
    Base.metadata,
    Column('user_profile_id', Integer, ForeignKey('user_profiles.id')),
    Column('interest_id', Integer, ForeignKey('interests.id'))
)

class Interest(Base):
    __tablename__ = "interests"

    id = Column(Integer, primary_key=True)
    name = Column(String, unique=True, index=True)
    category = Column(String, index=True)
    created_at = Column(DateTime, default=datetime.utcnow)

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(255), unique=True, nullable=False, index=True)
    phone = Column(String(20))
    password = Column(String(255), nullable=False)
    name = Column(String(255))
    birthdate = Column(Date)
    gender = Column(String(10))
    pendo_score = Column(Integer, default=0)
    avatar_url = Column(Text)
    bio = Column(Text)
    location_lat = Column(Numeric(9, 6))
    location_lon = Column(Numeric(9, 6))
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)

    # Relationships
    swipes_made = relationship("Swipe", foreign_keys="[Swipe.user_id]", back_populates="user")
    swipes_received = relationship("Swipe", foreign_keys="[Swipe.target_id]", back_populates="target")
    gifts_sent = relationship("Gift", foreign_keys="[Gift.from_id]", back_populates="sender")
    gifts_received = relationship("Gift", foreign_keys="[Gift.to_id]", back_populates="receiver")
    stories = relationship("Story", back_populates="user")
    interests = relationship("Interest", secondary="user_interests", back_populates="users")
    tribes = relationship("Tribe", secondary="tribe_members", back_populates="members")

    # Constraints
    __table_args__ = (
        CheckConstraint(
            "gender IN ('male', 'female', 'other')",
            name="check_gender"
        ),
        CheckConstraint(
            "pendo_score >= 0 AND pendo_score <= 100",
            name="check_pendo_score"
        ),
        CheckConstraint(
            "(location_lat IS NULL AND location_lon IS NULL) OR (location_lat IS NOT NULL AND location_lon IS NOT NULL)",
            name="check_location"
        ),
    )

    def __repr__(self):
        return f"<User(id={self.id}, email={self.email}, name={self.name})>"

class UserProfile(Base):
    __tablename__ = "user_profiles"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"), unique=True)
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
    current_tribe_id = Column(Integer, ForeignKey("tribes.id"))
    cultural_preferences = Column(JSON)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    user = relationship("User", back_populates="profile")
    interests = relationship("Interest", secondary=user_interests)

class UserScore(Base):
    __tablename__ = "user_scores"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"), unique=True)
    score = Column(Integer, default=0)
    level = Column(String, default="novice")  # novice, verified, active, trusted
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    user = relationship("User", back_populates="score")
