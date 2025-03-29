import logging
import sentry_sdk
from sentry_sdk.integrations.asgi import SentryAsgiMiddleware
from sentry_sdk.integrations.sqlalchemy import SqlalchemyIntegration
from prometheus_client import Counter, Histogram
from typing import Callable
from fastapi import FastAPI, Request
import time

from app.core.config import settings

# Настройка логирования
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Метрики Prometheus
REQUEST_COUNT = Counter(
    'http_requests_total',
    'Total HTTP requests',
    ['method', 'endpoint', 'status']
)

REQUEST_LATENCY = Histogram(
    'http_request_duration_seconds',
    'HTTP request latency',
    ['method', 'endpoint']
)

# Инициализация Sentry
def init_sentry() -> None:
    sentry_sdk.init(
        dsn=settings.SENTRY_DSN,
        environment=settings.ENVIRONMENT,
        integrations=[
            SqlalchemyIntegration(),
        ],
        traces_sample_rate=1.0,
    )

# Middleware для сбора метрик
async def metrics_middleware(request: Request, call_next: Callable):
    start_time = time.time()
    
    response = await call_next(request)
    
    duration = time.time() - start_time
    REQUEST_COUNT.labels(
        method=request.method,
        endpoint=request.url.path,
        status=response.status_code
    ).inc()
    
    REQUEST_LATENCY.labels(
        method=request.method,
        endpoint=request.url.path
    ).observe(duration)
    
    return response

# Функция для добавления мониторинга к приложению
def setup_monitoring(app: FastAPI) -> None:
    # Инициализация Sentry
    if settings.SENTRY_DSN:
        init_sentry()
        app.add_middleware(SentryAsgiMiddleware)
    
    # Добавление middleware для метрик
    app.middleware('http')(metrics_middleware)
    
    # Логирование запуска приложения
    logger.info(
        "Application startup complete. Environment: %s, Debug mode: %s",
        settings.ENVIRONMENT,
        settings.DEBUG
    )

# Функции для логирования событий
def log_user_action(user_id: int, action: str, details: dict = None) -> None:
    """
    Логирование действий пользователя
    """
    log_data = {
        "user_id": user_id,
        "action": action,
        "details": details or {},
    }
    logger.info("User action", extra=log_data)

def log_error(error: Exception, context: dict = None) -> None:
    """
    Логирование ошибок
    """
    log_data = {
        "error": str(error),
        "error_type": type(error).__name__,
        "context": context or {},
    }
    logger.error("Application error", extra=log_data)

def log_security_event(event_type: str, details: dict) -> None:
    """
    Логирование событий безопасности
    """
    log_data = {
        "event_type": event_type,
        "details": details,
    }
    logger.warning("Security event", extra=log_data)
