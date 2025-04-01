from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import Any, Dict
from pydantic import BaseModel

from app.core.deps import get_db
from app.schemas.auth import (
    RequestCode,
    VerifyCode,
    Register,
    Login,
    VerifyLogin,
    AuthResponse,
    TokenResponse,
)
from app.services.auth_service import AuthService
from app.services.email_service import EmailService
from app.services.redis_service import RedisService
from app.services.verification_service import VerificationService
from app.services.password_service import PasswordService

router = APIRouter()

def get_auth_service(db: Session = Depends(get_db)) -> AuthService:
    redis_service = RedisService()
    email_service = EmailService()
    verification_service = VerificationService(redis_service)
    return AuthService(db, email_service, redis_service, verification_service)

class GeneratePasswordResponse(BaseModel):
    password: str
    memorable_password: str

@router.get("/generate-password", response_model=GeneratePasswordResponse)
async def generate_password() -> Any:
    """
    Generate strong passwords for registration.
    Returns both a random strong password and a memorable password.
    """
    password_service = PasswordService()
    return {
        "password": password_service.generate_password(),
        "memorable_password": password_service.generate_memorable_password()
    }

@router.post("/request-code", status_code=status.HTTP_200_OK)
async def request_verification_code(
    data: RequestCode,
    auth_service: AuthService = Depends(get_auth_service),
) -> Any:
    """
    Request email verification code for registration or login.
    """
    await auth_service.request_code(data.email)
    return {"message": "Verification code sent"}

@router.post("/verify-code", status_code=status.HTTP_200_OK)
async def verify_code(
    data: VerifyCode,
    auth_service: AuthService = Depends(get_auth_service),
) -> Any:
    """
    Verify email verification code for registration.
    """
    if auth_service.verify_code(data.email, data.code):
        return {"message": "Code verified successfully"}
    raise HTTPException(
        status_code=status.HTTP_400_BAD_REQUEST,
        detail="Invalid verification code",
    )

@router.post("/register", response_model=AuthResponse)
async def register(
    data: Register,
    auth_service: AuthService = Depends(get_auth_service),
) -> Any:
    """
    Register new user.
    """
    # Verify code first
    if not auth_service.verify_code(data.email, data.code):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid verification code",
        )

    user, access_token, refresh_token = auth_service.register(data)
    return {
        "user": user,
        "token": {
            "access_token": access_token,
            "refresh_token": refresh_token,
            "token_type": "bearer",
            "expires_in": 3600,  # 1 hour
        },
    }

@router.post("/login", status_code=status.HTTP_200_OK)
async def login(
    data: Login,
    auth_service: AuthService = Depends(get_auth_service),
) -> Any:
    """
    Request login code.
    """
    await auth_service.request_login_code(data.email)
    return {"message": "Login code sent"}

@router.post("/verify-login", response_model=AuthResponse)
async def verify_login(
    data: VerifyLogin,
    auth_service: AuthService = Depends(get_auth_service),
) -> Any:
    """
    Verify login code and get access token.
    """
    user, access_token, refresh_token = auth_service.verify_login(data.email, data.code)
    return {
        "user": user,
        "token": {
            "access_token": access_token,
            "refresh_token": refresh_token,
            "token_type": "bearer",
            "expires_in": 3600,  # 1 hour
        },
    }

@router.post("/refresh", response_model=TokenResponse)
async def refresh_token(
    refresh_token: str,
    auth_service: AuthService = Depends(get_auth_service),
) -> Any:
    """
    Refresh access token.
    """
    new_access_token, new_refresh_token = auth_service.refresh_token(refresh_token)
    return {
        "access_token": new_access_token,
        "refresh_token": new_refresh_token,
        "token_type": "bearer",
        "expires_in": 3600,  # 1 hour
    }

@router.post("/logout", status_code=status.HTTP_200_OK)
async def logout(
    current_user_id: int = Depends(get_current_user_id),
    auth_service: AuthService = Depends(get_auth_service),
) -> Any:
    """
    Logout current user.
    """
    auth_service.logout(current_user_id)
    return {"message": "Successfully logged out"}
