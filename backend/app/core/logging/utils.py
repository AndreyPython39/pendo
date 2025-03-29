from functools import wraps
from time import time
from typing import Any, Callable, Dict, Optional, Type
from app.core.logging.logger import logger

def log_execution_time(func: Callable) -> Callable:
    """Decorator to log function execution time"""
    @wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time()
        try:
            result = func(*args, **kwargs)
            execution_time = time() - start_time
            logger.info(
                f"Function {func.__name__} executed in {execution_time:.3f}s",
                extra={
                    "function": func.__name__,
                    "execution_time": execution_time,
                    "success": True
                }
            )
            return result
        except Exception as e:
            execution_time = time() - start_time
            logger.error(
                f"Function {func.__name__} failed after {execution_time:.3f}s",
                extra={
                    "function": func.__name__,
                    "execution_time": execution_time,
                    "success": False,
                    "error": str(e)
                },
                exc_info=e
            )
            raise
    return wrapper

def log_method_calls(cls: Type) -> Type:
    """Class decorator to log method calls"""
    class_name = cls.__name__
    
    for attr_name, attr_value in cls.__dict__.items():
        if callable(attr_value) and not attr_name.startswith("_"):
            setattr(cls, attr_name, _create_logged_method(class_name, attr_name, attr_value))
    
    return cls

def _create_logged_method(class_name: str, method_name: str, method: Callable) -> Callable:
    @wraps(method)
    def wrapper(self, *args, **kwargs):
        try:
            logger.debug(
                f"Calling {class_name}.{method_name}",
                extra={
                    "class": class_name,
                    "method": method_name,
                    "args": args,
                    "kwargs": kwargs
                }
            )
            result = method(self, *args, **kwargs)
            logger.debug(
                f"Completed {class_name}.{method_name}",
                extra={
                    "class": class_name,
                    "method": method_name,
                    "success": True
                }
            )
            return result
        except Exception as e:
            logger.error(
                f"Error in {class_name}.{method_name}",
                extra={
                    "class": class_name,
                    "method": method_name,
                    "error": str(e),
                    "success": False
                },
                exc_info=e
            )
            raise
    return wrapper

def audit_log(
    action: str,
    user_id: Optional[str] = None,
    details: Optional[Dict[str, Any]] = None
) -> None:
    """Log audit events"""
    logger.info(
        f"Audit: {action}",
        extra={
            "audit": True,
            "action": action,
            "user_id": user_id,
            "details": details or {}
        }
    )

def error_boundary(func: Callable) -> Callable:
    """Decorator to catch and log all exceptions"""
    @wraps(func)
    def wrapper(*args, **kwargs):
        try:
            return func(*args, **kwargs)
        except Exception as e:
            logger.error(
                f"Uncaught exception in {func.__name__}",
                extra={
                    "function": func.__name__,
                    "error": str(e)
                },
                exc_info=e
            )
            raise
    return wrapper
