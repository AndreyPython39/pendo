from typing import List
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session

from app.api import deps
from app.crud import match as crud_match
from app.schemas.match import Match, MatchList
from app.models.user import User

router = APIRouter()

@router.get("/", response_model=MatchList)
def read_matches(
    skip: int = Query(0, ge=0),
    limit: int = Query(20, ge=1, le=100),
    active_only: bool = Query(True),
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Get all matches for current user
    """
    matches, total = crud_match.get_user_matches(
        db, current_user.id, skip, limit, active_only
    )
    return MatchList(matches=matches, total=total)

@router.get("/{match_id}", response_model=Match)
def read_match(
    match_id: int,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Get a specific match by ID
    """
    match = crud_match.get_match(db, match_id)
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
    
    # Check if current user is part of the match
    if current_user.id not in [match.user1_id, match.user2_id]:
        raise HTTPException(status_code=403, detail="Not authorized to view this match")
    
    return match

@router.delete("/{match_id}", response_model=Match)
def deactivate_match(
    match_id: int,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_user)
):
    """
    Deactivate (soft delete) a match
    """
    match = crud_match.get_match(db, match_id)
    if not match:
        raise HTTPException(status_code=404, detail="Match not found")
    
    # Check if current user is part of the match
    if current_user.id not in [match.user1_id, match.user2_id]:
        raise HTTPException(status_code=403, detail="Not authorized to deactivate this match")
    
    return crud_match.deactivate_match(db, match_id)
