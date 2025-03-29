from fastapi import HTTPException, Request, Response
from starlette.middleware.base import BaseHTTPMiddleware
import secrets
from typing import Optional
from app.core.config import settings

class CSRFMiddleware(BaseHTTPMiddleware):
    def __init__(self, app):
        super().__init__(app)
        self.secret = settings.SECRET_KEY

    def _generate_csrf_token(self) -> str:
        """Generate a new CSRF token"""
        return secrets.token_urlsafe(32)

    def _verify_csrf_token(self, request_token: str, session_token: str) -> bool:
        """Verify that the request token matches the session token"""
        if not request_token or not session_token:
            return False
        return secrets.compare_digest(request_token, session_token)

    async def dispatch(self, request: Request, call_next) -> Response:
        if settings.ENVIRONMENT == "production":
            # Skip CSRF check for non-mutation methods
            if request.method in ("GET", "HEAD", "OPTIONS", "TRACE"):
                response = await call_next(request)
                return response

            # Skip CSRF check for API endpoints that use JWT
            if request.url.path.startswith("/api/"):
                response = await call_next(request)
                return response

            # Get the CSRF token from the request
            request_token = request.headers.get("X-CSRF-Token")
            session_token = request.session.get("csrf_token")

            # For the first request, set a new CSRF token
            if not session_token:
                session_token = self._generate_csrf_token()
                request.session["csrf_token"] = session_token

            # Verify the token for mutation requests
            if not self._verify_csrf_token(request_token, session_token):
                raise HTTPException(
                    status_code=403,
                    detail="CSRF token missing or invalid"
                )

        response = await call_next(request)

        # Always set the CSRF token in the response header for web clients
        if not request.url.path.startswith("/api/"):
            response.headers["X-CSRF-Token"] = request.session.get("csrf_token", "")

        return response
