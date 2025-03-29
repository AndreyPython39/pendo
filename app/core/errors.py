from typing import Any, Dict, Optional
from fastapi import HTTPException, Request, status
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from starlette.exceptions import HTTPException as StarletteHTTPException
from app.core.logging import security_logger

class PendoException(HTTPException):
    """Base exception for Pendo application"""
    def __init__(
        self,
        status_code: int,
        detail: str,
        error_code: Optional[str] = None,
        headers: Optional[Dict[str, Any]] = None
    ):
        super().__init__(status_code=status_code, detail=detail)
        self.error_code = error_code
        self.headers = headers


class SecurityException(PendoException):
    """Security-related exceptions"""
    def __init__(
        self,
        detail: str,
        error_code: str,
        status_code: int = status.HTTP_403_FORBIDDEN
    ):
        super().__init__(
            status_code=status_code,
            detail=detail,
            error_code=error_code
        )
        # Log security exceptions
        security_logger.warning(
            f"Security exception: {error_code} - {detail}",
            extra={"error_code": error_code}
        )


class ValidationException(PendoException):
    """Validation-related exceptions"""
    def __init__(
        self,
        detail: str,
        error_code: str,
        status_code: int = status.HTTP_400_BAD_REQUEST
    ):
        super().__init__(
            status_code=status_code,
            detail=detail,
            error_code=error_code
        )


class RateLimitException(PendoException):
    """Rate limit exceeded exceptions"""
    def __init__(
        self,
        detail: str = "Rate limit exceeded",
        retry_after: int = 60
    ):
        super().__init__(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail=detail,
            headers={"Retry-After": str(retry_after)}
        )


async def pendo_exception_handler(request: Request, exc: PendoException) -> JSONResponse:
    """Handler for Pendo exceptions"""
    content = {
        "detail": exc.detail,
        "status_code": exc.status_code
    }
    if exc.error_code:
        content["error_code"] = exc.error_code

    return JSONResponse(
        status_code=exc.status_code,
        content=content,
        headers=exc.headers
    )


async def validation_exception_handler(
    request: Request,
    exc: RequestValidationError
) -> JSONResponse:
    """Handler for request validation errors"""
    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content={
            "detail": "Validation error",
            "errors": exc.errors()
        }
    )


async def http_exception_handler(
    request: Request,
    exc: StarletteHTTPException
) -> JSONResponse:
    """Handler for HTTP exceptions"""
    return JSONResponse(
        status_code=exc.status_code,
        content={"detail": exc.detail}
    )


# Common error codes
class ErrorCodes:
    # Authentication errors
    AUTH_INVALID_CREDENTIALS = "AUTH001"
    AUTH_TOKEN_EXPIRED = "AUTH002"
    AUTH_TOKEN_INVALID = "AUTH003"
    AUTH_USER_INACTIVE = "AUTH004"
    AUTH_USER_NOT_VERIFIED = "AUTH005"

    # Rate limiting errors
    RATE_LIMIT_EXCEEDED = "RATE001"
    RATE_LIMIT_USER = "RATE002"

    # Content validation errors
    CONTENT_INVALID_IMAGE = "CONT001"
    CONTENT_INVALID_TEXT = "CONT002"
    CONTENT_FORBIDDEN_WORDS = "CONT003"
    CONTENT_SIZE_EXCEEDED = "CONT004"

    # User errors
    USER_NOT_FOUND = "USER001"
    USER_ALREADY_EXISTS = "USER002"
    USER_BLOCKED = "USER003"
    USER_INSUFFICIENT_SCORE = "USER004"

    # Tribe errors
    TRIBE_NOT_FOUND = "TRIBE001"
    TRIBE_MEMBER_LIMIT = "TRIBE002"
    TRIBE_CREATE_TIMEOUT = "TRIBE003"
    TRIBE_ALREADY_MEMBER = "TRIBE004"

    # Match errors
    MATCH_NOT_FOUND = "MATCH001"
    MATCH_ALREADY_EXISTS = "MATCH002"
    MATCH_EXPIRED = "MATCH003"

    # Moderation errors
    MOD_QUEUE_FULL = "MOD001"
    MOD_INVALID_STATUS = "MOD002"
    MOD_PERMISSION_DENIED = "MOD003"
