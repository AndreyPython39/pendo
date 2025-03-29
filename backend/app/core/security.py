from datetime import datetime, timedelta
from typing import Optional, Union
import jwt
from passlib.context import CryptContext
from fastapi import HTTPException, Security
from fastapi.security import OAuth2PasswordBearer
from starlette.status import HTTP_403_FORBIDDEN
from app.core.config import settings
import time
from redis import Redis
import logging

logger = logging.getLogger(__name__)

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl=f"{settings.API_V1_PREFIX}/auth/login/access-token")

# Redis клиент для rate limiting
redis_client = Redis(
    host=settings.REDIS_HOST,
    port=settings.REDIS_PORT,
    db=settings.REDIS_DB,
    password=settings.REDIS_PASSWORD,
    decode_responses=True
)

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Проверка пароля"""
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    """Хэширование пароля"""
    return pwd_context.hash(password)

def create_access_token(subject: Union[str, int], expires_delta: Optional[timedelta] = None) -> str:
    """Создание JWT токена"""
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(
            minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES
        )
    
    to_encode = {"exp": expire, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm="HS256")
    return encoded_jwt

def verify_token(token: str) -> Optional[str]:
    """Проверка JWT токена"""
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=["HS256"])
        return payload["sub"]
    except jwt.JWTError:
        return None

class RateLimiter:
    """Класс для ограничения частоты запросов"""
    
    def __init__(self, key_prefix: str, limit: int, period: int):
        self.key_prefix = key_prefix
        self.limit = limit
        self.period = period

    async def is_allowed(self, key: str) -> bool:
        """Проверка, разрешен ли запрос"""
        redis_key = f"{self.key_prefix}:{key}"
        current = int(time.time())
        pipeline = redis_client.pipeline()
        
        # Удаляем устаревшие записи
        pipeline.zremrangebyscore(redis_key, 0, current - self.period)
        # Добавляем текущий запрос
        pipeline.zadd(redis_key, {str(current): current})
        # Получаем количество запросов за период
        pipeline.zcard(redis_key)
        # Устанавливаем время жизни ключа
        pipeline.expire(redis_key, self.period)
        
        _, _, count, _ = pipeline.execute()
        
        return count <= self.limit

class SecurityManager:
    """Менеджер безопасности"""
    
    @staticmethod
    async def check_rate_limit(ip: str, endpoint: str) -> bool:
        """Проверка ограничения частоты запросов"""
        limiter = RateLimiter(
            key_prefix=f"ratelimit:{endpoint}",
            limit=settings.RATE_LIMIT_PER_MINUTE,
            period=60
        )
        return await limiter.is_allowed(ip)

    @staticmethod
    def validate_password(password: str) -> bool:
        """Валидация пароля"""
        if len(password) < 8:
            return False
        if not any(c.isupper() for c in password):
            return False
        if not any(c.islower() for c in password):
            return False
        if not any(c.isdigit() for c in password):
            return False
        return True

    @staticmethod
    def sanitize_input(text: str) -> str:
        """Санитизация пользовательского ввода"""
        # Удаляем потенциально опасные символы
        return text.replace("<", "&lt;").replace(">", "&gt;")

    @staticmethod
    async def log_security_event(event_type: str, details: dict) -> None:
        """Логирование событий безопасности"""
        logger.warning(f"Security event: {event_type}", extra=details)

# Декоратор для проверки rate limit
def check_rate_limit():
    async def decorator(request):
        if not await SecurityManager.check_rate_limit(request.client.host, request.url.path):
            raise HTTPException(
                status_code=HTTP_429_TOO_MANY_REQUESTS,
                detail="Too many requests"
            )
        return True
    return Security(decorator)

# Декоратор для проверки прав доступа
def check_permissions(*required_permissions):
    async def decorator(current_user = Security(oauth2_scheme)):
        if not all(perm in current_user.permissions for perm in required_permissions):
            raise HTTPException(
                status_code=HTTP_403_FORBIDDEN,
                detail="Not enough permissions"
            )
        return current_user
    return Security(decorator)
