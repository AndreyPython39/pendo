from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from app.core.deps import get_current_user, get_db
from app.models.swipe import Swipe, SwipeAction
from app.models.chat import Match
from app.schemas.swipe import SwipeCreate, SwipeResponse

router = APIRouter()

@router.post("/like", response_model=SwipeResponse)
def create_like(
    target_id: str,
    current_user = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Create a like swipe"""
    # Проверяем, не было ли уже свайпа
    existing_swipe = db.query(Swipe).filter(
        Swipe.user_id == current_user.id,
        Swipe.target_id == target_id
    ).first()
    
    if existing_swipe:
        raise HTTPException(status_code=400, detail="Already swiped on this user")

    # Создаем свайп
    swipe = Swipe(
        user_id=current_user.id,
        target_id=target_id,
        action=SwipeAction.LIKE
    )
    db.add(swipe)
    
    # Проверяем взаимный лайк
    mutual_like = db.query(Swipe).filter(
        Swipe.user_id == target_id,
        Swipe.target_id == current_user.id,
        Swipe.action == SwipeAction.LIKE
    ).first()
    
    # Если есть взаимный лайк, создаем матч
    if mutual_like:
        match = Match(
            user1_id=current_user.id,
            user2_id=target_id
        )
        db.add(match)
    
    db.commit()
    db.refresh(swipe)
    return swipe

@router.post("/dislike", response_model=SwipeResponse)
def create_dislike(
    target_id: str,
    current_user = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Create a dislike swipe"""
    existing_swipe = db.query(Swipe).filter(
        Swipe.user_id == current_user.id,
        Swipe.target_id == target_id
    ).first()
    
    if existing_swipe:
        raise HTTPException(status_code=400, detail="Already swiped on this user")

    swipe = Swipe(
        user_id=current_user.id,
        target_id=target_id,
        action=SwipeAction.DISLIKE
    )
    db.add(swipe)
    db.commit()
    db.refresh(swipe)
    return swipe
