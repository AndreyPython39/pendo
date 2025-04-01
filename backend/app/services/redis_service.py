from datetime import timedelta
from typing import Optional, Any
import json
from redis import Redis
from app.core.config import settings

class RedisService:
    def __init__(self):
        self.redis = Redis(
            host=settings.REDIS_HOST,
            port=settings.REDIS_PORT,
            db=settings.REDIS_DB,
            password=settings.REDIS_PASSWORD,
            decode_responses=True,
        )

    def set(self, key: str, value: str, ex: Optional[timedelta] = None) -> None:
        """Set key to hold the string value with optional expiration"""
        self.redis.set(key, value, ex=ex)

    def get(self, key: str) -> Optional[str]:
        """Get the value of key"""
        return self.redis.get(key)

    def delete(self, key: str) -> None:
        """Delete key"""
        self.redis.delete(key)

    def set_json(self, key: str, value: Any, ex: Optional[timedelta] = None) -> None:
        """Set key to hold the JSON value with optional expiration"""
        json_value = json.dumps(value)
        self.redis.set(key, json_value, ex=ex)

    def get_json(self, key: str) -> Optional[Any]:
        """Get the JSON value of key"""
        value = self.redis.get(key)
        if value:
            return json.loads(value)
        return None

    # Token Management
    def set_refresh_token(self, user_id: int, token: str) -> None:
        """Save refresh token with expiration"""
        key = f"refresh_token:{user_id}"
        self.set(key, token, ex=timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS))

    def get_refresh_token(self, user_id: int) -> Optional[str]:
        """Get refresh token"""
        key = f"refresh_token:{user_id}"
        return self.get(key)

    def delete_refresh_token(self, user_id: int) -> None:
        """Delete refresh token"""
        key = f"refresh_token:{user_id}"
        self.delete(key)

    # Rate Limiting
    def check_rate_limit(self, key: str, limit: int, period: int) -> bool:
        """Check if rate limit is exceeded"""
        current = self.redis.get(key)
        if not current:
            self.redis.setex(key, period, 1)
            return True
        
        count = int(current)
        if count >= limit:
            return False
        
        self.redis.incr(key)
        return True

    # Cache Management
    def set_cache(self, key: str, value: Any, ex: Optional[timedelta] = None) -> None:
        """Set cache with optional expiration"""
        self.set_json(f"cache:{key}", value, ex=ex)

    def get_cache(self, key: str) -> Optional[Any]:
        """Get cache value"""
        return self.get_json(f"cache:{key}")

    def delete_cache(self, key: str) -> None:
        """Delete cache"""
        self.delete(f"cache:{key}")

    def clear_cache_pattern(self, pattern: str) -> None:
        """Clear all cache keys matching pattern"""
        keys = self.redis.keys(f"cache:{pattern}")
        if keys:
            self.redis.delete(*keys)

    # Session Management
    def set_session(self, session_id: str, data: dict, ex: Optional[timedelta] = None) -> None:
        """Set session data with optional expiration"""
        self.set_json(f"session:{session_id}", data, ex=ex)

    def get_session(self, session_id: str) -> Optional[dict]:
        """Get session data"""
        return self.get_json(f"session:{session_id}")

    def delete_session(self, session_id: str) -> None:
        """Delete session"""
        self.delete(f"session:{session_id}")

    # Online Status
    def set_user_online(self, user_id: int) -> None:
        """Set user as online"""
        self.redis.sadd("online_users", user_id)

    def set_user_offline(self, user_id: int) -> None:
        """Set user as offline"""
        self.redis.srem("online_users", user_id)

    def is_user_online(self, user_id: int) -> bool:
        """Check if user is online"""
        return self.redis.sismember("online_users", user_id)

    def get_online_users(self) -> set:
        """Get all online users"""
        return self.redis.smembers("online_users")
