import logging
import json
import sys
from datetime import datetime
from typing import Any, Dict, Optional
from pathlib import Path
from logging.handlers import RotatingFileHandler
from elasticsearch import Elasticsearch
from app.core.config import settings

class CustomFormatter(logging.Formatter):
    def format(self, record: logging.LogRecord) -> str:
        log_data = {
            "timestamp": datetime.utcnow().isoformat(),
            "level": record.levelname,
            "message": record.getMessage(),
            "module": record.module,
            "function": record.funcName,
            "line": record.lineno,
        }
        
        # Add extra fields if available
        if hasattr(record, "extra"):
            log_data.update(record.extra)
            
        # Add exception info if available
        if record.exc_info:
            log_data["exception"] = self.formatException(record.exc_info)
            
        return json.dumps(log_data)

class ElasticsearchHandler(logging.Handler):
    def __init__(self, es_client: Elasticsearch, index_prefix: str):
        super().__init__()
        self.es_client = es_client
        self.index_prefix = index_prefix

    def emit(self, record: logging.LogRecord):
        try:
            log_entry = self.format(record)
            index_name = f"{self.index_prefix}-{datetime.utcnow():%Y.%m.%d}"
            self.es_client.index(
                index=index_name,
                document=json.loads(log_entry)
            )
        except Exception:
            self.handleError(record)

class Logger:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance._initialize_logger()
        return cls._instance
    
    def _initialize_logger(self):
        self.logger = logging.getLogger("pendo")
        self.logger.setLevel(logging.DEBUG)
        
        # Create logs directory if it doesn't exist
        log_dir = Path("logs")
        log_dir.mkdir(exist_ok=True)
        
        # Console handler
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setLevel(logging.INFO)
        console_handler.setFormatter(CustomFormatter())
        self.logger.addHandler(console_handler)
        
        # File handler with rotation
        file_handler = RotatingFileHandler(
            "logs/pendo.log",
            maxBytes=10*1024*1024,  # 10MB
            backupCount=5
        )
        file_handler.setLevel(logging.DEBUG)
        file_handler.setFormatter(CustomFormatter())
        self.logger.addHandler(file_handler)
        
        # Elasticsearch handler
        if settings.ELASTICSEARCH_ENABLED:
            es_client = Elasticsearch([settings.ELASTICSEARCH_URL])
            es_handler = ElasticsearchHandler(
                es_client=es_client,
                index_prefix="pendo-logs"
            )
            es_handler.setLevel(logging.INFO)
            es_handler.setFormatter(CustomFormatter())
            self.logger.addHandler(es_handler)
    
    def log(
        self,
        level: int,
        message: str,
        extra: Optional[Dict[str, Any]] = None,
        exc_info: Optional[Exception] = None
    ):
        self.logger.log(
            level,
            message,
            extra={"extra": extra} if extra else None,
            exc_info=exc_info
        )
    
    def debug(self, message: str, **kwargs):
        self.log(logging.DEBUG, message, **kwargs)
    
    def info(self, message: str, **kwargs):
        self.log(logging.INFO, message, **kwargs)
    
    def warning(self, message: str, **kwargs):
        self.log(logging.WARNING, message, **kwargs)
    
    def error(self, message: str, **kwargs):
        self.log(logging.ERROR, message, **kwargs)
    
    def critical(self, message: str, **kwargs):
        self.log(logging.CRITICAL, message, **kwargs)

# Global logger instance
logger = Logger()
