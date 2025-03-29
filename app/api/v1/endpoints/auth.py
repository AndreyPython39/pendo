from datetime import timedelta
from typing import Any
from fastapi import APIRouter, Body, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app import crud, models, schemas
from app.api import deps
from app.core import security
from app.core.config import settings

router = APIRouter()


@router.post("/register", response_model=schemas.User)
def register(
    *,
    db: Session = Depends(deps.get_db),
    user_in: schemas.UserCreate,
    profile_in: schemas.UserProfileCreate,
) -> Any:
    """
    Register new user with profile.
    """
    if not user_in.has_contact:
        raise HTTPException(
            status_code=400,
            detail="Either email or phone must be provided"
        )

    if user_in.email:
        user = crud.user.get_by_email(db, email=user_in.email)
        if user:
            raise HTTPException(
                status_code=400,
                detail="Email already registered"
            )
    
    if user_in.phone:
        user = crud.user.get_by_phone(db, phone=user_in.phone)
        if user:
            raise HTTPException(
                status_code=400,
                detail="Phone already registered"
            )

    user = crud.user.create(db, obj_in=user_in)
    crud.user.create_profile(db, user_id=user.id, profile_in=profile_in)
    crud.user.create_score(
        db, 
        user_id=user.id, 
        score_in=schemas.UserScoreCreate(score=20)  # Initial score for profile creation
    )
    return user


@router.post("/login/access-token", response_model=schemas.Token)
def login_access_token(
    db: Session = Depends(deps.get_db),
    form_data: OAuth2PasswordRequestForm = Depends()
) -> Any:
    """
    OAuth2 compatible token login, get an access token for future requests.
    Username can be either email or phone number.
    """
    user = crud.user.authenticate(
        db, identifier=form_data.username, password=form_data.password
    )
    if not user:
        raise HTTPException(
            status_code=400,
            detail="Incorrect login credentials"
        )
    elif not user.is_active:
        raise HTTPException(
            status_code=400,
            detail="Inactive user"
        )
    
    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    return {
        "access_token": security.create_access_token(
            user.id, expires_delta=access_token_expires
        ),
        "token_type": "bearer",
    }


@router.post("/verify-email/{token}", response_model=schemas.User)
def verify_email(
    *,
    db: Session = Depends(deps.get_db),
    token: str,
) -> Any:
    """
    Verify user's email using verification token.
    """
    user_id = security.verify_email_token(token)
    if not user_id:
        raise HTTPException(
            status_code=400,
            detail="Invalid verification token"
        )
    
    user = crud.user.get(db, id=user_id)
    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )
    
    if user.is_verified:
        raise HTTPException(
            status_code=400,
            detail="Email already verified"
        )
    
    user_in = schemas.UserUpdate(is_verified=True)
    user = crud.user.update(db, db_obj=user, obj_in=user_in)
    crud.user.update_score(db, user_id=user.id, points=50)  # Score for verification
    return user


@router.post("/password-recovery/{email}", response_model=schemas.Msg)
def recover_password(
    email: str,
    db: Session = Depends(deps.get_db)
) -> Any:
    """
    Password Recovery
    """
    user = crud.user.get_by_email(db, email=email)
    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )
    
    password_reset_token = security.generate_password_reset_token(email)
    # TODO: Send the token via email using background task
    return {"msg": "Password recovery email sent"}
