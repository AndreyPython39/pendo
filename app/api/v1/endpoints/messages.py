from typing import Any, List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import datetime

from app import models, schemas
from app.api import deps

router = APIRouter()


@router.get("/{match_id}", response_model=List[schemas.Message])
def read_messages(
    match_id: int,
    db: Session = Depends(deps.get_db),
    current_user: models.User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Retrieve messages for a match.
    """
    # Verify user is part of the match
    match = db.query(models.Match).filter(
        models.Match.id == match_id,
        ((models.Match.user1_id == current_user.id) | 
         (models.Match.user2_id == current_user.id))
    ).first()
    
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
        
    messages = db.query(models.Message).filter(
        models.Message.match_id == match_id
    ).order_by(models.Message.sent_at.asc()).all()
    
    return messages


@router.post("/{match_id}", response_model=schemas.Message)
def create_message(
    *,
    db: Session = Depends(deps.get_db),
    match_id: int,
    message_in: schemas.MessageCreate,
    current_user: models.User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Create new message.
    """
    # Verify user is part of the match
    match = db.query(models.Match).filter(
        models.Match.id == match_id,
        ((models.Match.user1_id == current_user.id) | 
         (models.Match.user2_id == current_user.id))
    ).first()
    
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
        
    message = models.Message(
        match_id=match_id,
        sender_id=current_user.id,
        content=message_in.content,
        sent_at=datetime.utcnow()
    )
    db.add(message)
    db.commit()
    db.refresh(message)
    
    return message
