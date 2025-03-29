from functools import wraps
from typing import Any, Callable, Optional
import redis
import json
import pickle
from datetime import timedelta

from app.core.config import settings

# Инициализация Redis
redis_client = redis.Redis(
    host=settings.REDIS_HOST,
    port=settings.REDIS_PORT,
    db=settings.REDIS_DB,
    password=settings.REDIS_PASSWORD,
    decode_responses=True
)

class Cache:
    @staticmethod
    def key_builder(prefix: str, *args, **kwargs) -> str:
        """
        Построение ключа кэша из префикса и параметров
        """
        key_parts = [prefix]
        if args:
            key_parts.extend(str(arg) for arg in args)
        if kwargs:
            key_parts.extend(f"{k}:{v}" for k, v in sorted(kwargs.items()))
        return ":".join(key_parts)

    @staticmethod
    def set(key: str, value: Any, expire: Optional[int] = None) -> None:
        """
        Сохранение значения в кэш
        """
        try:
            if isinstance(value, (dict, list)):
                value = json.dumps(value)
            elif not isinstance(value, (str, int, float)):
                value = pickle.dumps(value)
            
            redis_client.set(key, value, ex=expire)
        except Exception as e:
            logger.error(f"Cache set error: {e}")

    @staticmethod
    def get(key: str, default: Any = None) -> Any:
        """
        Получение значения из кэша
        """
        try:
            value = redis_client.get(key)
            if value is None:
                return default
                
            try:
                return json.loads(value)
            except json.JSONDecodeError:
                try:
                    return pickle.loads(value)
                except:
                    return value
        except Exception as e:
            logger.error(f"Cache get error: {e}")
            return default

    @staticmethod
    def delete(key: str) -> None:
        """
        Удаление значения из кэша
        """
        try:
            redis_client.delete(key)
        except Exception as e:
            logger.error(f"Cache delete error: {e}")

    @staticmethod
    def cached(prefix: str, expire: Optional[int] = None):
        """
        Декоратор для кэширования результатов функции
        """
        def decorator(func: Callable):
            @wraps(func)
            async def wrapper(*args, **kwargs):
                # Построение ключа кэша
                cache_key = Cache.key_builder(prefix, *args, **kwargs)
                
                # Попытка получить значение из кэша
                cached_value = Cache.get(cache_key)
                if cached_value is not None:
                    return cached_value
                
                # Если значения нет в кэше, вызываем функцию
                result = await func(*args, **kwargs)
                
                # Сохраняем результат в кэш
                Cache.set(cache_key, result, expire)
                
                return result
            return wrapper
        return decorator

# Примеры использования:

@Cache.cached("user_profile", expire=300)  # кэш на 5 минут
async def get_user_profile(user_id: int):
    return await db.query(User).filter(User.id == user_id).first()

@Cache.cached("user_matches", expire=60)  # кэш на 1 минуту
async def get_user_matches(user_id: int):
    return await db.query(Match).filter(
        (Match.user1_id == user_id) | (Match.user2_id == user_id)
    ).all()

# Инвалидация кэша при обновлении данных
async def update_user_profile(user_id: int, data: dict):
    # Обновляем данные
    user = await db.query(User).filter(User.id == user_id).first()
    for key, value in data.items():
        setattr(user, key, value)
    await db.commit()
    
    # Инвалидируем кэш
    Cache.delete(Cache.key_builder("user_profile", user_id))

# Массовая инвалидация кэша
def invalidate_user_caches(user_id: int):
    """
    Инвалидация всех кэшей, связанных с пользователем
    """
    patterns = [
        f"user_profile:{user_id}",
        f"user_matches:{user_id}",
        f"user_stories:{user_id}",
        f"user_tribes:{user_id}",
    ]
    for pattern in patterns:
        for key in redis_client.scan_iter(pattern):
            Cache.delete(key)
