from typing import Any, Optional
import json
import redis
from app.core.config import settings

class RedisCache:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance._initialize()
        return cls._instance
    
    def _initialize(self):
        self.redis = redis.Redis(
            host=settings.REDIS_HOST,
            port=settings.REDIS_PORT,
            decode_responses=True
        )
        
        # Default TTL for cache entries (1 hour)
        self.default_ttl = 3600
        
        # Cache prefixes for different types of data
        self.prefixes = {
            'user': 'user:',
            'match': 'match:',
            'chat': 'chat:',
            'story': 'story:',
            'tribe': 'tribe:',
        }
    
    def _get_key(self, prefix: str, key: str) -> str:
        """Get full Redis key with prefix"""
        return f"{self.prefixes.get(prefix, '')}{key}"
    
    def get(self, prefix: str, key: str) -> Optional[Any]:
        """Get value from cache"""
        try:
            value = self.redis.get(self._get_key(prefix, key))
            return json.loads(value) if value else None
        except Exception as e:
            print(f"Redis get error: {e}")
            return None
    
    def set(
        self,
        prefix: str,
        key: str,
        value: Any,
        ttl: Optional[int] = None
    ) -> bool:
        """Set value in cache"""
        try:
            full_key = self._get_key(prefix, key)
            self.redis.set(
                full_key,
                json.dumps(value),
                ex=ttl or self.default_ttl
            )
            return True
        except Exception as e:
            print(f"Redis set error: {e}")
            return False
    
    def delete(self, prefix: str, key: str) -> bool:
        """Delete value from cache"""
        try:
            self.redis.delete(self._get_key(prefix, key))
            return True
        except Exception as e:
            print(f"Redis delete error: {e}")
            return False
    
    def exists(self, prefix: str, key: str) -> bool:
        """Check if key exists in cache"""
        try:
            return self.redis.exists(self._get_key(prefix, key)) > 0
        except Exception as e:
            print(f"Redis exists error: {e}")
            return False
    
    def increment(self, prefix: str, key: str) -> Optional[int]:
        """Increment counter"""
        try:
            return self.redis.incr(self._get_key(prefix, key))
        except Exception as e:
            print(f"Redis increment error: {e}")
            return None
    
    def expire(self, prefix: str, key: str, ttl: int) -> bool:
        """Set expiration for key"""
        try:
            return self.redis.expire(self._get_key(prefix, key), ttl)
        except Exception as e:
            print(f"Redis expire error: {e}")
            return False
    
    def clear_prefix(self, prefix: str) -> bool:
        """Clear all keys with given prefix"""
        try:
            pattern = f"{self.prefixes.get(prefix, prefix)}*"
            keys = self.redis.keys(pattern)
            if keys:
                self.redis.delete(*keys)
            return True
        except Exception as e:
            print(f"Redis clear_prefix error: {e}")
            return False
    
    # User-specific methods
    def cache_user(self, user_id: str, user_data: dict, ttl: Optional[int] = None):
        return self.set('user', user_id, user_data, ttl)
    
    def get_user(self, user_id: str) -> Optional[dict]:
        return self.get('user', user_id)
    
    # Match-specific methods
    def cache_matches(self, user_id: str, matches: list, ttl: Optional[int] = None):
        return self.set('match', f"matches:{user_id}", matches, ttl)
    
    def get_matches(self, user_id: str) -> Optional[list]:
        return self.get('match', f"matches:{user_id}")
    
    # Chat-specific methods
    def cache_chat_messages(
        self,
        chat_id: str,
        messages: list,
        ttl: Optional[int] = None
    ):
        return self.set('chat', f"messages:{chat_id}", messages, ttl)
    
    def get_chat_messages(self, chat_id: str) -> Optional[list]:
        return self.get('chat', f"messages:{chat_id}")
    
    # Story-specific methods
    def cache_stories(self, user_id: str, stories: list, ttl: Optional[int] = None):
        return self.set('story', f"stories:{user_id}", stories, ttl)
    
    def get_stories(self, user_id: str) -> Optional[list]:
        return self.get('story', f"stories:{user_id}")
    
    # Tribe-specific methods
    def cache_tribe(self, tribe_id: str, tribe_data: dict, ttl: Optional[int] = None):
        return self.set('tribe', tribe_id, tribe_data, ttl)
    
    def get_tribe(self, tribe_id: str) -> Optional[dict]:
        return self.get('tribe', tribe_id)

# Global cache instance
cache = RedisCache()
