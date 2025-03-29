from typing import Any, List
from fastapi import APIRouter, Body, Depends, HTTPException, Query
from sqlalchemy.orm import Session

from app import crud, schemas
from app.api import deps
from app.models import User

router = APIRouter()


@router.get("/", response_model=List[schemas.User])
def read_users(
    db: Session = Depends(deps.get_db),
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Retrieve users. Only for superusers.
    """
    users = crud.user.get_multi(db, skip=skip, limit=limit)
    return users


@router.get("/me", response_model=schemas.User)
def read_user_me(
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get current user.
    """
    return current_user


@router.put("/me", response_model=schemas.User)
def update_user_me(
    *,
    db: Session = Depends(deps.get_db),
    password: str = Body(None),
    email: str = Body(None),
    phone: str = Body(None),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Update own user.
    """
    current_user_data = schemas.UserUpdate(password=password, email=email, phone=phone)
    user = crud.user.update(db, db_obj=current_user, obj_in=current_user_data)
    return user


@router.get("/me/profile", response_model=schemas.UserProfile)
def read_user_me_profile(
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get current user's profile.
    """
    return current_user.profile


@router.put("/me/profile", response_model=schemas.UserProfile)
def update_user_me_profile(
    *,
    db: Session = Depends(deps.get_db),
    profile_in: schemas.UserProfileUpdate,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Update own profile.
    """
    profile = crud.user.update_profile(
        db, user_id=current_user.id, profile_in=profile_in
    )
    return profile


@router.get("/me/score", response_model=schemas.UserScore)
def read_user_me_score(
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get current user's Pendo score.
    """
    return current_user.score


@router.get("/nearby", response_model=List[schemas.User])
def read_nearby_users(
    *,
    db: Session = Depends(deps.get_db),
    latitude: float = Query(..., ge=-90, le=90),
    longitude: float = Query(..., ge=-180, le=180),
    radius_km: float = Query(default=10, gt=0, le=100),
    skip: int = 0,
    limit: int = 50,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get users near the specified location.
    """
    users = crud.user.get_nearby_users(
        db,
        latitude=latitude,
        longitude=longitude,
        radius_km=radius_km,
        skip=skip,
        limit=limit
    )
    return users


@router.get("/{user_id}", response_model=schemas.User)
def read_user_by_id(
    user_id: int,
    current_user: User = Depends(deps.get_current_active_user),
    db: Session = Depends(deps.get_db),
) -> Any:
    """
    Get a specific user by id.
    """
    user = crud.user.get(db, id=user_id)
    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )
    return user


@router.get("/{user_id}/profile", response_model=schemas.UserProfile)
def read_user_profile(
    user_id: int,
    current_user: User = Depends(deps.get_current_active_user),
    db: Session = Depends(deps.get_db),
) -> Any:
    """
    Get a specific user's profile.
    """
    user = crud.user.get(db, id=user_id)
    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )
    return user.profile


# Admin endpoints
@router.post("/{user_id}/verify", response_model=schemas.User)
def verify_user(
    user_id: int,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Verify a user (admin only).
    """
    user = crud.user.get(db, id=user_id)
    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )
    
    user_in = schemas.UserUpdate(is_verified=True)
    user = crud.user.update(db, db_obj=user, obj_in=user_in)
    crud.user.update_score(db, user_id=user.id, points=50)  # Score for verification
    return user


@router.post("/{user_id}/block", response_model=schemas.User)
def block_user(
    user_id: int,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Block a user (admin only).
    """
    user = crud.user.get(db, id=user_id)
    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )
    
    user_in = schemas.UserUpdate(is_active=False)
    user = crud.user.update(db, db_obj=user, obj_in=user_in)
    return user
