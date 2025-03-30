from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.api import deps
from app.crud import swipe as crud_swipe
from app.schemas.swipe import SwipeCreate, SwipeResponse, SwipeMatch
from app.models.user import User

router = APIRouter()

@router.post("/", response_model=SwipeMatch)
def create_swipe(
    swipe: SwipeCreate,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Create a new swipe (like/pass/superlike)
    """
    # Check if user has already swiped on target
    if crud_swipe.has_swiped(db, current_user.id, swipe.target_id):
        raise HTTPException(
            status_code=400,
            detail="You have already swiped on this user"
        )
    
    # Create swipe and check for match
    db_swipe, is_match = crud_swipe.create_swipe(db, current_user.id, swipe)
    
    # If it's a match, get target user info
    target_user = None
    match_id = None
    if is_match:
        target_user = {
            "id": db_swipe.target.id,
            "name": db_swipe.target.profile.name if db_swipe.target.profile else None,
            "photo": db_swipe.target.profile.profile_photos[0] if db_swipe.target.profile and db_swipe.target.profile.profile_photos else None
        }
        # В реальном приложении здесь также нужно создать match в таблице matches
        # и отправить уведомление обоим пользователям
    
    return SwipeMatch(
        is_match=is_match,
        match_id=match_id,
        target_user=target_user
    )

@router.get("/me", response_model=List[SwipeResponse])
def read_my_swipes(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Get all swipes made by current user
    """
    return crud_swipe.get_user_swipes(db, current_user.id, skip, limit)

@router.get("/received", response_model=List[SwipeResponse])
def read_received_swipes(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Get all swipes received by current user
    """
    return crud_swipe.get_received_swipes(db, current_user.id, skip, limit)

@router.get("/matches", response_model=List[dict])  # TODO: Create proper match schema
def read_matches(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Get all matches (mutual likes) for current user
    """
    matches = crud_swipe.get_matches(db, current_user.id, skip, limit)
    return [
        {
            "user": {
                "id": user.id,
                "name": user.profile.name if user.profile else None,
                "photo": user.profile.profile_photos[0] if user.profile and user.profile.profile_photos else None
            },
            "matched_at": swipe.created_at
        }
        for user, swipe in matches
    ]
