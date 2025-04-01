from datetime import datetime, timedelta
from typing import Optional, Tuple
import jwt
from sqlalchemy.orm import Session
from fastapi import HTTPException, status

from app.core.config import settings
from app.models.user import User, UserProfile
from app.schemas.auth import Register
from app.services.email_service import EmailService
from app.services.redis_service import RedisService
from app.services.verification_service import VerificationService

class AuthService:
    def __init__(
        self,
        db: Session,
        email_service: EmailService,
        redis_service: RedisService,
        verification_service: VerificationService,
    ):
        self.db = db
        self.email_service = email_service
        self.redis_service = redis_service
        self.verification_service = verification_service

    def request_code(self, email: str) -> None:
        """
        Request verification code for email
        """
        # Check if email exists for registration
        user = self.db.query(User).filter(User.email == email).first()
        if user:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email already registered",
            )

        # Generate and send verification code
        code = self.verification_service.generate_code()
        self.verification_service.save_code(email, code)
        self.email_service.send_verification_code(email, code)

    def request_login_code(self, email: str) -> None:
        """
        Request login code for email
        """
        # Check if email exists
        user = self.db.query(User).filter(User.email == email).first()
        if not user:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email not registered",
            )

        # Generate and send login code
        code = self.verification_service.generate_code()
        self.verification_service.save_code(f"login:{email}", code)
        self.email_service.send_login_code(email, code)

    def verify_code(self, email: str, code: str) -> bool:
        """
        Verify email verification code
        """
        stored_code = self.verification_service.get_code(email)
        if not stored_code or stored_code != code:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invalid verification code",
            )
        self.verification_service.delete_code(email)
        return True

    def verify_login(self, email: str, code: str) -> Tuple[User, str, str]:
        """
        Verify login code and return user with tokens
        """
        stored_code = self.verification_service.get_code(f"login:{email}")
        if not stored_code or stored_code != code:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invalid login code",
            )
        
        user = self.db.query(User).filter(User.email == email).first()
        if not user:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="User not found",
            )

        self.verification_service.delete_code(f"login:{email}")

        # Generate tokens
        access_token = self._create_access_token(user.id)
        refresh_token = self._create_refresh_token(user.id)

        # Save refresh token
        self.redis_service.set_refresh_token(user.id, refresh_token)

        return user, access_token, refresh_token

    def register(self, data: Register) -> Tuple[User, str, str]:
        """
        Register new user
        """
        # Create user
        user = User(
            email=data.email,
            name=data.name,
            birthdate=data.birthdate,
            gender=data.gender,
        )
        self.db.add(user)
        self.db.flush()  # Get user.id

        # Create user profile
        profile = UserProfile(
            user_id=user.id,
            name=data.name,
            birthdate=data.birthdate,
            gender=data.gender,
            looking_for=data.looking_for,
            bio=data.bio,
        )
        self.db.add(profile)
        self.db.commit()
        self.db.refresh(user)

        # Generate tokens
        access_token = self._create_access_token(user.id)
        refresh_token = self._create_refresh_token(user.id)

        # Save refresh token
        self.redis_service.set_refresh_token(user.id, refresh_token)

        # Send welcome email
        self.email_service.send_welcome_email(user.email, user.name)

        return user, access_token, refresh_token

    def refresh_token(self, refresh_token: str) -> Tuple[str, str]:
        """
        Create new access token from refresh token
        """
        try:
            payload = jwt.decode(
                refresh_token,
                settings.JWT_REFRESH_SECRET_KEY,
                algorithms=[settings.JWT_ALGORITHM],
            )
            user_id = payload.get("sub")
            if not user_id:
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    detail="Invalid refresh token",
                )

            # Verify refresh token in Redis
            stored_token = self.redis_service.get_refresh_token(user_id)
            if not stored_token or stored_token != refresh_token:
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    detail="Invalid refresh token",
                )

            # Generate new tokens
            new_access_token = self._create_access_token(user_id)
            new_refresh_token = self._create_refresh_token(user_id)

            # Update refresh token in Redis
            self.redis_service.set_refresh_token(user_id, new_refresh_token)

            return new_access_token, new_refresh_token

        except jwt.JWTError:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid refresh token",
            )

    def logout(self, user_id: int) -> None:
        """
        Remove refresh token from Redis
        """
        self.redis_service.delete_refresh_token(user_id)

    def _create_access_token(self, user_id: int) -> str:
        expire = datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
        to_encode = {
            "sub": str(user_id),
            "exp": expire,
            "type": "access"
        }
        return jwt.encode(
            to_encode,
            settings.JWT_SECRET_KEY,
            algorithm=settings.JWT_ALGORITHM,
        )

    def _create_refresh_token(self, user_id: int) -> str:
        expire = datetime.utcnow() + timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
        to_encode = {
            "sub": str(user_id),
            "exp": expire,
            "type": "refresh"
        }
        return jwt.encode(
            to_encode,
            settings.JWT_REFRESH_SECRET_KEY,
            algorithm=settings.JWT_ALGORITHM,
        )
