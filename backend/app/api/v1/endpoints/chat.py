from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from app.core.deps import get_current_user, get_db
from app.models.chat import Match, Message
from app.schemas.chat import MessageCreate, MessageResponse, MatchResponse

router = APIRouter()

@router.get("/matches", response_model=List[MatchResponse])
def get_matches(
    current_user = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get all matches for current user"""
    matches = db.query(Match).filter(
        (Match.user1_id == current_user.id) | (Match.user2_id == current_user.id),
        Match.is_active == True
    ).all()
    return matches

@router.get("/{match_id}/history", response_model=List[MessageResponse])
def get_chat_history(
    match_id: str,
    current_user = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get chat history for a match"""
    match = db.query(Match).filter(Match.id == match_id).first()
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
    
    if match.user1_id != current_user.id and match.user2_id != current_user.id:
        raise HTTPException(status_code=403, detail="Not authorized to view this chat")
    
    messages = db.query(Message).filter(Message.match_id == match_id).order_by(Message.created_at).all()
    return messages

@router.post("/send", response_model=MessageResponse)
def send_message(
    message: MessageCreate,
    current_user = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Send a message in a chat"""
    match = db.query(Match).filter(Match.id == message.match_id).first()
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
    
    if match.user1_id != current_user.id and match.user2_id != current_user.id:
        raise HTTPException(status_code=403, detail="Not authorized to send messages in this chat")
    
    db_message = Message(
        match_id=message.match_id,
        sender_id=current_user.id,
        content=message.content
    )
    db.add(db_message)
    db.commit()
    db.refresh(db_message)
    return db_message
