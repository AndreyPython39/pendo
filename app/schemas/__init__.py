from .user import User, UserCreate, UserUpdate, UserInDB
from .token import Token, TokenPayload
from .tribe import Tribe, TribeCreate, TribeUpdate
from .match import Match, Like
from .message import Message, MessageCreate

# For Pydantic v2
class Config:
    from_attributes = True
