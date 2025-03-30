from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base

# Create base class
Base = declarative_base()

# Import all models here
from ..models.user import User, UserProfile, UserScore
from ..models.gift import VirtualGift, GiftTransaction, GiftCollection
from ..models.story import Story, LiveStream, StoryReaction
from ..models.tribe import Tribe, TribeEvent, TribeVote
from ..models.matches import Swipe, Match, Message, IcebreakerQuestion, IcebreakerAnswer

# Create SQLAlchemy engine
engine = create_engine('postgresql://pendo:pendopass@localhost/pendo')

# Create sessionmaker
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Make sure all models are imported
