from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base

# Create base class
Base = declarative_base()

# Import all models here
from ..models.user import User, UserProfile, UserScore
from ..models.gift import VirtualGift, GiftTransaction, GiftCollection
from ..models.story import Story, LiveStream, StoryView, StreamComment
from ..models.tribe import Tribe, TribeEvent, TribeVote
from ..models.swipe import Swipe
from ..models.match import Match
from ..models.message import Message
from ..models.icebreaker import IcebreakerQuestion, IcebreakerAnswer

# Create SQLAlchemy engine
engine = create_engine('postgresql://pendo:pendopass@localhost/pendo')

# Create sessionmaker
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Make sure all models are imported
