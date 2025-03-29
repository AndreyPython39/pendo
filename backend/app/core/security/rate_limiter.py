from datetime import datetime, timedelta
from typing import Optional, Tuple
from fastapi import HTTPException, Request
from app.core.caching.redis_cache import cache

class RateLimiter:
    def __init__(
        self,
        key_prefix: str,
        max_requests: int,
        window_seconds: int
    ):
        self.key_prefix = key_prefix
        self.max_requests = max_requests
        self.window_seconds = window_seconds
    
    def _get_cache_key(self, identifier: str) -> str:
        return f"{self.key_prefix}:{identifier}"
    
    def _get_window_key(self, identifier: str) -> str:
        return f"{self.key_prefix}:window:{identifier}"
    
    def check_rate_limit(self, identifier: str) -> Tuple[bool, Optional[int]]:
        """
        Check if the rate limit has been exceeded.
        Returns (is_allowed, retry_after_seconds)
        """
        cache_key = self._get_cache_key(identifier)
        window_key = self._get_window_key(identifier)
        
        # Get current count and window start time
        current_count = cache.get('rate_limit', cache_key) or 0
        window_start = cache.get('rate_limit', window_key)
        
        now = datetime.utcnow()
        
        # If window has expired or doesn't exist, start new window
        if not window_start or (
            datetime.fromisoformat(window_start) + 
            timedelta(seconds=self.window_seconds) < now
        ):
            cache.set('rate_limit', cache_key, 1, self.window_seconds)
            cache.set(
                'rate_limit',
                window_key,
                now.isoformat(),
                self.window_seconds
            )
            return True, None
        
        # If within window, check count
        if current_count >= self.max_requests:
            window_end = (
                datetime.fromisoformat(window_start) + 
                timedelta(seconds=self.window_seconds)
            )
            retry_after = int((window_end - now).total_seconds())
            return False, retry_after
        
        # Increment counter
        cache.increment('rate_limit', cache_key)
        return True, None

class RateLimitMiddleware:
    def __init__(
        self,
        max_requests: int = 100,
        window_seconds: int = 60
    ):
        self.limiter = RateLimiter(
            key_prefix="rate_limit",
            max_requests=max_requests,
            window_seconds=window_seconds
        )
    
    async def __call__(
        self,
        request: Request,
        call_next
    ):
        # Get identifier (IP address or user ID)
        identifier = request.client.host
        if user_id := request.headers.get("X-User-ID"):
            identifier = user_id
        
        # Check rate limit
        is_allowed, retry_after = self.limiter.check_rate_limit(identifier)
        
        if not is_allowed:
            raise HTTPException(
                status_code=429,
                detail={
                    "message": "Too many requests",
                    "retry_after": retry_after
                }
            )
        
        return await call_next(request)

# Specific rate limiters
AUTH_LIMITER = RateLimiter(
    key_prefix="auth",
    max_requests=5,
    window_seconds=300  # 5 minutes
)

API_LIMITER = RateLimiter(
    key_prefix="api",
    max_requests=100,
    window_seconds=60  # 1 minute
)

CHAT_LIMITER = RateLimiter(
    key_prefix="chat",
    max_requests=60,
    window_seconds=60  # 1 minute
)

MATCHING_LIMITER = RateLimiter(
    key_prefix="matching",
    max_requests=100,
    window_seconds=3600  # 1 hour
)
