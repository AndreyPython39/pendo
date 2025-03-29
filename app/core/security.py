from datetime import datetime, timedelta
from typing import Any, Dict, Optional, Union
import secrets
import re
from jose import jwt, JWTError
from passlib.context import CryptContext
from fastapi import Depends, HTTPException, Request, status
from fastapi.security import OAuth2PasswordBearer
import requests

from app.core.config import settings
from app.core.errors import SecurityException, ErrorCodes
from app.core.logging import log_security_event

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl=f"{settings.API_V1_PREFIX}/auth/login/access-token")

ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = settings.ACCESS_TOKEN_EXPIRE_MINUTES
REFRESH_TOKEN_EXPIRE_DAYS = 30
PASSWORD_RESET_TOKEN_EXPIRE_HOURS = 24
EMAIL_VERIFICATION_TOKEN_EXPIRE_HOURS = 48

# Password validation patterns
PASSWORD_MIN_LENGTH = 8
PASSWORD_PATTERNS = {
    r"[A-Z]": "uppercase letter",
    r"[a-z]": "lowercase letter",
    r"[0-9]": "number",
    r"[!@#$%^&*(),.?\":{}|<>]": "special character"
}


def verify_recaptcha(token: str) -> bool:
    """Verify reCAPTCHA token"""
    if not settings.RECAPTCHA_ENABLED:
        return True

    try:
        response = requests.post(
            "https://www.google.com/recaptcha/api/siteverify",
            data={
                "secret": settings.RECAPTCHA_SECRET_KEY.get_secret_value(),
                "response": token
            }
        )
        result = response.json()
        return result.get("success", False)
    except Exception as e:
        log_security_event(
            "recaptcha_verification_failed",
            "high",
            {"error": str(e)}
        )
        return False


def create_access_token(subject: Union[str, Any], expires_delta: Optional[timedelta] = None) -> str:
    """Create JWT access token"""
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)

    to_encode = {
        "exp": expire,
        "sub": str(subject),
        "type": "access",
        "jti": secrets.token_urlsafe(8)
    }
    encoded_jwt = jwt.encode(
        to_encode,
        settings.SECRET_KEY.get_secret_value(),
        algorithm=ALGORITHM
    )
    return encoded_jwt


def create_refresh_token(subject: Union[str, Any]) -> str:
    """Create JWT refresh token"""
    expire = datetime.utcnow() + timedelta(days=REFRESH_TOKEN_EXPIRE_DAYS)
    to_encode = {
        "exp": expire,
        "sub": str(subject),
        "type": "refresh",
        "jti": secrets.token_urlsafe(8)
    }
    return jwt.encode(
        to_encode,
        settings.SECRET_KEY.get_secret_value(),
        algorithm=ALGORITHM
    )


def verify_token(token: str, token_type: str) -> Optional[str]:
    """Verify JWT token"""
    try:
        payload = jwt.decode(
            token,
            settings.SECRET_KEY.get_secret_value(),
            algorithms=[ALGORITHM]
        )
        if payload.get("type") != token_type:
            return None
        return payload.get("sub")
    except JWTError:
        return None


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify password against hash"""
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password: str) -> str:
    """Generate password hash"""
    return pwd_context.hash(password)


def validate_password(password: str) -> list:
    """
    Validate password strength and return list of validation errors
    """
    errors = []
    
    if len(password) < PASSWORD_MIN_LENGTH:
        errors.append(f"Password must be at least {PASSWORD_MIN_LENGTH} characters long")
    
    for pattern, description in PASSWORD_PATTERNS.items():
        if not re.search(pattern, password):
            errors.append(f"Password must contain at least one {description}")
    
    return errors


def generate_password_reset_token(email: str) -> str:
    """Generate password reset token"""
    expire = datetime.utcnow() + timedelta(hours=PASSWORD_RESET_TOKEN_EXPIRE_HOURS)
    to_encode = {
        "exp": expire,
        "sub": email,
        "type": "password_reset",
        "jti": secrets.token_urlsafe(8)
    }
    return jwt.encode(
        to_encode,
        settings.SECRET_KEY.get_secret_value(),
        algorithm=ALGORITHM
    )


def verify_password_reset_token(token: str) -> Optional[str]:
    """Verify password reset token"""
    return verify_token(token, "password_reset")


def generate_email_verification_token(user_id: int) -> str:
    """Generate email verification token"""
    expire = datetime.utcnow() + timedelta(hours=EMAIL_VERIFICATION_TOKEN_EXPIRE_HOURS)
    to_encode = {
        "exp": expire,
        "sub": str(user_id),
        "type": "email_verification",
        "jti": secrets.token_urlsafe(8)
    }
    return jwt.encode(
        to_encode,
        settings.SECRET_KEY.get_secret_value(),
        algorithm=ALGORITHM
    )


def verify_email_token(token: str) -> Optional[str]:
    """Verify email verification token"""
    return verify_token(token, "email_verification")


def sanitize_phone_number(phone: str) -> str:
    """
    Sanitize and validate phone number
    Returns sanitized phone number or raises ValueError
    """
    # Remove all non-digit characters except +
    sanitized = re.sub(r'[^\d+]', '', phone)
    
    # Ensure it starts with + and has 10-15 digits
    if not re.match(r'^\+\d{10,15}$', sanitized):
        raise ValueError("Invalid phone number format")
    
    return sanitized


def mask_sensitive_data(data: str, visible_chars: int = 4) -> str:
    """
    Mask sensitive data like email or phone number
    Example: mask_sensitive_data("user@example.com") -> "u***@example.com"
    """
    if '@' in data:  # Email
        username, domain = data.split('@')
        if len(username) <= visible_chars:
            masked_username = username
        else:
            masked_username = username[:visible_chars] + '*' * (len(username) - visible_chars)
        return f"{masked_username}@{domain}"
    else:  # Phone or other
        if len(data) <= visible_chars:
            return data
        return data[:visible_chars] + '*' * (len(data) - visible_chars)


async def verify_csrf_token(request: Request) -> None:
    """Verify CSRF token for mutation requests"""
    if request.method in ("GET", "HEAD", "OPTIONS", "TRACE"):
        return

    if settings.ENVIRONMENT == "production":
        csrf_token = request.headers.get("X-CSRF-Token")
        session_token = request.session.get("csrf_token")

        if not csrf_token or not session_token or not secrets.compare_digest(csrf_token, session_token):
            raise SecurityException(
                detail="CSRF token missing or invalid",
                error_code="CSRF001",
                status_code=status.HTTP_403_FORBIDDEN
            )
