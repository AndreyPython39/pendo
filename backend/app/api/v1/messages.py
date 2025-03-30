from typing import List
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session

from app.api import deps
from app.crud import message as crud_message
from app.crud import match as crud_match
from app.schemas.message import MessageCreate, Message, MessageList
from app.models.user import User

router = APIRouter()

@router.post("/", response_model=Message)
def create_message(
    message: MessageCreate,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Create a new message
    """
    # Check if match exists and user is part of it
    match = crud_match.get_match(db, message.match_id)
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
    
    if current_user.id not in [match.user1_id, match.user2_id]:
        raise HTTPException(
            status_code=403,
            detail="Not authorized to send messages in this match"
        )
    
    # Check if match is active
    if not match.is_active:
        raise HTTPException(
            status_code=400,
            detail="Cannot send messages in an inactive match"
        )
    
    return crud_message.create_message(db, current_user.id, message)

@router.get("/match/{match_id}", response_model=MessageList)
def read_messages(
    match_id: int,
    skip: int = Query(0, ge=0),
    limit: int = Query(50, ge=1, le=100),
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Get all messages in a match
    """
    # Check if match exists and user is part of it
    match = crud_match.get_match(db, match_id)
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
    
    if current_user.id not in [match.user1_id, match.user2_id]:
        raise HTTPException(
            status_code=403,
            detail="Not authorized to view messages in this match"
        )
    
    messages, total, unread = crud_message.get_messages(db, match_id, skip, limit)
    return MessageList(messages=messages, total=total, unread_count=unread)

@router.post("/match/{match_id}/read")
def mark_messages_read(
    match_id: int,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Mark all messages in a match as read
    """
    # Check if match exists and user is part of it
    match = crud_match.get_match(db, match_id)
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
    
    if current_user.id not in [match.user1_id, match.user2_id]:
        raise HTTPException(
            status_code=403,
            detail="Not authorized to mark messages in this match"
        )
    
    marked_count = crud_message.mark_messages_as_read(db, match_id, current_user.id)
    return {"marked_count": marked_count}

@router.get("/unread/count")
def get_unread_count(
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Get total number of unread messages for current user
    """
    return {"unread_count": crud_message.get_unread_count(db, current_user.id)}
