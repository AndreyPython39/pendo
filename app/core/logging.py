import logging
import json
from datetime import datetime
from typing import Any, Dict, Optional
from fastapi import Request, Response
from starlette.middleware.base import BaseHTTPMiddleware
from app.core.config import settings

# Configure logging
logging.basicConfig(
    level=logging.INFO if settings.ENVIRONMENT == "production" else logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

# Create loggers
api_logger = logging.getLogger("api")
auth_logger = logging.getLogger("auth")
moderation_logger = logging.getLogger("moderation")
security_logger = logging.getLogger("security")


class RequestResponseLoggingMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next) -> Response:
        # Don't log health check endpoints
        if request.url.path in ["/health", "/metrics"]:
            return await call_next(request)

        # Start timer
        start_time = datetime.utcnow()

        # Get request body for specific endpoints
        request_body = None
        if request.url.path.startswith("/api/") and request.method in ["POST", "PUT", "PATCH"]:
            try:
                request_body = await request.json()
                # Mask sensitive data
                if "password" in request_body:
                    request_body["password"] = "***"
                if "token" in request_body:
                    request_body["token"] = "***"
            except:
                pass

        # Process request
        response = await call_next(request)

        # Calculate duration
        duration = (datetime.utcnow() - start_time).total_seconds()

        # Log request details
        log_data = {
            "timestamp": start_time.isoformat(),
            "client_ip": request.client.host,
            "method": request.method,
            "path": request.url.path,
            "status_code": response.status_code,
            "duration": duration,
            "user_agent": request.headers.get("user-agent"),
        }

        # Add request body for non-GET requests
        if request_body:
            log_data["request_body"] = request_body

        # Log based on status code
        if response.status_code >= 500:
            api_logger.error(json.dumps(log_data))
        elif response.status_code >= 400:
            api_logger.warning(json.dumps(log_data))
        else:
            api_logger.info(json.dumps(log_data))

        return response


def log_auth_event(
    event_type: str,
    user_id: Optional[int],
    success: bool,
    details: Optional[Dict[str, Any]] = None
) -> None:
    """Log authentication events"""
    log_data = {
        "timestamp": datetime.utcnow().isoformat(),
        "event_type": event_type,
        "user_id": user_id,
        "success": success,
    }
    if details:
        log_data.update(details)

    if success:
        auth_logger.info(json.dumps(log_data))
    else:
        auth_logger.warning(json.dumps(log_data))


def log_moderation_event(
    action: str,
    moderator_id: int,
    target_type: str,
    target_id: int,
    reason: Optional[str] = None,
    details: Optional[Dict[str, Any]] = None
) -> None:
    """Log moderation actions"""
    log_data = {
        "timestamp": datetime.utcnow().isoformat(),
        "action": action,
        "moderator_id": moderator_id,
        "target_type": target_type,
        "target_id": target_id,
        "reason": reason,
    }
    if details:
        log_data.update(details)

    moderation_logger.info(json.dumps(log_data))


def log_security_event(
    event_type: str,
    severity: str,
    details: Dict[str, Any]
) -> None:
    """Log security-related events"""
    log_data = {
        "timestamp": datetime.utcnow().isoformat(),
        "event_type": event_type,
        "severity": severity,
        "details": details,
    }

    if severity == "high":
        security_logger.error(json.dumps(log_data))
    elif severity == "medium":
        security_logger.warning(json.dumps(log_data))
    else:
        security_logger.info(json.dumps(log_data))
