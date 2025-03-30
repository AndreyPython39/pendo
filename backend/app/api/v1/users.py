from fastapi import APIRouter, Depends, HTTPException, Body
from sqlalchemy.orm import Session
from typing import List, Optional
from datetime import datetime

from app.core.deps import get_current_user, get_db
from app.schemas.user import UserUpdate, UserProfile, UserResponse
from app.crud.user import user_crud
from app.models.user import User

router = APIRouter()

@router.get("/me", response_model=UserResponse)
def get_current_user_profile(
    current_user: User = Depends(get_current_user)
):
    """Get current user profile"""
    return current_user

@router.put("/update_profile", response_model=UserResponse)
def update_user_profile(
    profile_update: UserUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Update user profile"""
    return user_crud.update_user(db, current_user.id, profile_update)

@router.post("/location", response_model=UserResponse)
def update_user_location(
    lat: float = Body(...),
    lon: float = Body(...),
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Update user location"""
    return user_crud.update_location(db, current_user.id, lat, lon)

@router.get("/{user_id}", response_model=UserProfile)
def get_user_profile(
    user_id: str,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Get user profile by ID"""
    user = user_crud.get(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user
