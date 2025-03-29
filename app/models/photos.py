from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, Enum
from sqlalchemy.orm import relationship
import enum
from app.models.base import Base


class PhotoStatus(enum.Enum):
    PENDING = "pending"
    APPROVED = "approved"
    REJECTED = "rejected"


class UserPhoto(Base):
    __tablename__ = "user_photos"

    id = Column(Integer, primary_key=True, index=True)
    profile_id = Column(Integer, ForeignKey("user_profiles.id"))
    url = Column(String, nullable=False)
    is_primary = Column(Boolean, default=False)
    status = Column(Enum(PhotoStatus), default=PhotoStatus.PENDING)
    moderation_note = Column(String, nullable=True)

    # Relationships
    profile = relationship("UserProfile", back_populates="photos")
