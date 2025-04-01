import random
import string
from datetime import timedelta
from app.services.redis_service import RedisService

class VerificationService:
    def __init__(self, redis_service: RedisService):
        self.redis = redis_service
        self.code_length = 6
        self.code_ttl = timedelta(minutes=10)

    def generate_code(self) -> str:
        """Generate random verification code"""
        return ''.join(random.choices(string.digits, k=self.code_length))

    def save_code(self, key: str, code: str) -> None:
        """Save verification code to Redis"""
        self.redis.set(f"verification:{key}", code, ex=self.code_ttl)

    def get_code(self, key: str) -> str:
        """Get verification code from Redis"""
        return self.redis.get(f"verification:{key}")

    def delete_code(self, key: str) -> None:
        """Delete verification code from Redis"""
        self.redis.delete(f"verification:{key}")

    def verify_code(self, key: str, code: str) -> bool:
        """Verify code matches stored code"""
        stored_code = self.get_code(key)
        if not stored_code or stored_code != code:
            return False
        self.delete_code(key)
        return True
