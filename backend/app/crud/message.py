from typing import List, Optional, Tuple
from sqlalchemy.orm import Session
from sqlalchemy import and_

from app.models.message import Message
from app.schemas.message import MessageCreate

def create_message(db: Session, sender_id: int, message: MessageCreate) -> Message:
    db_message = Message(
        match_id=message.match_id,
        sender_id=sender_id,
        content=message.content,
        media_url=message.media_url,
        media_type=message.media_type
    )
    db.add(db_message)
    db.commit()
    db.refresh(db_message)
    return db_message

def get_messages(
    db: Session,
    match_id: int,
    skip: int = 0,
    limit: int = 50
) -> Tuple[List[Message], int, int]:
    """Get messages for a match with total count and unread count"""
    query = db.query(Message).filter(Message.match_id == match_id)
    
    total = query.count()
    unread = query.filter(Message.is_read == False).count()
    
    messages = query.order_by(Message.created_at.desc())\
                   .offset(skip).limit(limit).all()
    
    return messages, total, unread

def mark_messages_as_read(
    db: Session,
    match_id: int,
    user_id: int
) -> int:
    """Mark all unread messages in a match as read for a user"""
    result = db.query(Message).filter(
        and_(
            Message.match_id == match_id,
            Message.sender_id != user_id,  # Only mark messages from other user
            Message.is_read == False
        )
    ).update({"is_read": True})
    
    db.commit()
    return result

def get_unread_count(db: Session, user_id: int) -> int:
    """Get total number of unread messages for a user across all matches"""
    return db.query(Message).join(Message.match)\
             .filter(
                 and_(
                     Message.is_read == False,
                     Message.sender_id != user_id,
                     or_(
                         Match.user1_id == user_id,
                         Match.user2_id == user_id
                     )
                 )
             ).count()
