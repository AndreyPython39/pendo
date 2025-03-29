import time
from typing import Callable
from fastapi import Request, Response
from starlette.middleware.base import BaseHTTPMiddleware
from app.core.logging.logger import logger

class LoggingMiddleware(BaseHTTPMiddleware):
    async def dispatch(
        self, request: Request, call_next: Callable
    ) -> Response:
        start_time = time.time()
        
        # Extract request details
        request_details = {
            "method": request.method,
            "url": str(request.url),
            "client_ip": request.client.host,
            "user_agent": request.headers.get("user-agent"),
        }
        
        try:
            # Log request
            logger.info(
                f"Incoming request: {request.method} {request.url}",
                extra=request_details
            )
            
            # Process request
            response = await call_next(request)
            
            # Calculate processing time
            process_time = time.time() - start_time
            
            # Log response
            logger.info(
                f"Request completed: {request.method} {request.url}",
                extra={
                    **request_details,
                    "status_code": response.status_code,
                    "process_time": f"{process_time:.3f}s"
                }
            )
            
            return response
            
        except Exception as e:
            # Log error
            logger.error(
                f"Request failed: {request.method} {request.url}",
                extra={
                    **request_details,
                    "error": str(e),
                    "process_time": f"{time.time() - start_time:.3f}s"
                },
                exc_info=e
            )
            raise
