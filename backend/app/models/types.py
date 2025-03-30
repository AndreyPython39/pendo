from enum import Enum

class GiftType(str, Enum):
    FLOWER = 'flower'
    HEART = 'heart'
    STAR = 'star'
    DIAMOND = 'diamond'

class ChatStatus(str, Enum):
    ACTIVE = 'active'
    BLOCKED = 'blocked'
    DELETED = 'deleted'

class EventType(str, Enum):
    MATCH = 'match'
    MESSAGE = 'message'
    GIFT = 'gift'
    STORY = 'story'

class Gender(str, Enum):
    MALE = 'male'
    FEMALE = 'female'
    OTHER = 'other'
