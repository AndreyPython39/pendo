from sqlalchemy import Column, String, Table, ForeignKey
from sqlalchemy.orm import relationship

from .base import Base

# Association table for many-to-many relationship between users and interests
user_interests = Table(
    'user_interests',
    Base.metadata,
    Column('user_id', String, ForeignKey('users.id')),
    Column('interest_id', String, ForeignKey('interests.id'))
)

class Interest(Base):
    __tablename__ = "interests"

    id = Column(String, primary_key=True)
    name = Column(String, unique=True, index=True)
    category = Column(String, index=True)
    
    # Relationships
    users = relationship(
        "User",
        secondary=user_interests,
        back_populates="interests"
    )
