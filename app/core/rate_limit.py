from fastapi import HTTPException, Request
from fastapi.responses import JSONResponse
from starlette.middleware.base import BaseHTTPMiddleware
import time
from typing import Dict, Tuple
from app.core.config import settings

class RateLimiter:
    def __init__(self, requests_per_minute: int = 60):
        self.requests_per_minute = requests_per_minute
        self.requests: Dict[str, list] = {}

    def is_allowed(self, ip: str) -> Tuple[bool, float]:
        now = time.time()
        minute_ago = now - 60

        # Clean old requests
        if ip in self.requests:
            self.requests[ip] = [req_time for req_time in self.requests[ip] if req_time > minute_ago]
        else:
            self.requests[ip] = []

        # Check if allowed
        if len(self.requests[ip]) >= self.requests_per_minute:
            wait_time = 60 - (now - self.requests[ip][0])
            return False, wait_time

        # Add new request
        self.requests[ip].append(now)
        return True, 0


class RateLimitMiddleware(BaseHTTPMiddleware):
    def __init__(self, app, requests_per_minute: int = 60):
        super().__init__(app)
        self.limiter = RateLimiter(requests_per_minute)

    async def dispatch(self, request: Request, call_next):
        if settings.ENVIRONMENT == "production":
            # Get client IP
            forwarded = request.headers.get("X-Forwarded-For")
            if forwarded:
                ip = forwarded.split(",")[0]
            else:
                ip = request.client.host

            # Check whitelist (for admin IPs)
            if ip in settings.RATE_LIMIT_WHITELIST:
                return await call_next(request)

            # Check rate limit
            allowed, wait_time = self.limiter.is_allowed(ip)
            if not allowed:
                return JSONResponse(
                    status_code=429,
                    content={
                        "detail": "Too many requests",
                        "wait_seconds": round(wait_time)
                    }
                )

        return await call_next(request)


# Special rate limiters for sensitive endpoints
auth_limiter = RateLimiter(requests_per_minute=5)  # Stricter limit for auth
swipe_limiter = RateLimiter(requests_per_minute=30)  # Limit for swipes
report_limiter = RateLimiter(requests_per_minute=10)  # Limit for reports
