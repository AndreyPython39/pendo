# Logging System Documentation

## Overview
The logging system in Pendo is designed to provide comprehensive monitoring, debugging, and auditing capabilities across the entire application. It supports structured logging with multiple output formats and destinations.

## Features

### Log Levels
- DEBUG: Detailed information for debugging
- INFO: General operational information
- WARNING: Warning messages for potential issues
- ERROR: Error messages for actual problems
- CRITICAL: Critical issues requiring immediate attention

### Log Formats
- JSON: Structured logging for machine processing
- Plain Text: Human-readable format for development
- Custom formats can be added as needed

### Output Destinations
1. Console
   - Real-time monitoring
   - Development environment
   - Colored output for different levels

2. Files
   - Rotating log files
   - Size-based rotation (10MB)
   - Keep last 5 backup files
   - JSON format for easy parsing

3. Elasticsearch
   - Centralized log storage
   - Advanced search capabilities
   - Real-time log aggregation
   - Kibana dashboard integration

## Implementation

### Core Components

1. Logger Class
```python
class Logger:
    def log(level, message, extra, exc_info)
    def debug(message, **kwargs)
    def info(message, **kwargs)
    def warning(message, **kwargs)
    def error(message, **kwargs)
    def critical(message, **kwargs)
```

2. Custom Formatter
```python
class CustomFormatter:
    def format(record)  # Formats log records as JSON
```

3. Elasticsearch Handler
```python
class ElasticsearchHandler:
    def emit(record)  # Sends logs to Elasticsearch
```

### Middleware

1. Logging Middleware
- HTTP request logging
- Response time tracking
- Error capturing
- Request/Response correlation

### Utilities

1. Decorators
```python
@log_execution_time  # Log function execution time
@log_method_calls    # Log class method calls
@error_boundary      # Catch and log all exceptions
```

2. Audit Logging
```python
audit_log(action, user_id, details)  # Log audit events
```

## Configuration

### Environment Variables
```env
LOG_LEVEL=INFO
LOG_FORMAT=json
LOG_FILE_PATH=logs/pendo.log
LOG_ROTATION_SIZE=10485760
LOG_BACKUP_COUNT=5
ELASTICSEARCH_ENABLED=true
ELASTICSEARCH_URL=http://localhost:9200
```

### Log Entry Structure
```json
{
  "timestamp": "2025-03-29T20:32:45Z",
  "level": "INFO",
  "message": "User logged in",
  "module": "auth",
  "function": "login",
  "line": 42,
  "extra": {
    "user_id": "123",
    "ip_address": "192.168.1.1"
  }
}
```

## Use Cases

### Request Logging
```python
logger.info(
    "Incoming request",
    extra={
        "method": "POST",
        "path": "/api/v1/auth/login",
        "ip": "192.168.1.1"
    }
)
```

### Error Logging
```python
try:
    # Some code
except Exception as e:
    logger.error(
        "Operation failed",
        extra={"operation": "user_update"},
        exc_info=e
    )
```

### Audit Logging
```python
audit_log(
    action="user.profile.update",
    user_id="123",
    details={"fields": ["name", "email"]}
)
```

## Monitoring & Analysis

### Kibana Dashboards
1. System Health
   - Error rates
   - Response times
   - Request volumes

2. User Activity
   - Login attempts
   - Feature usage
   - Error patterns

3. Audit Trail
   - User actions
   - Data modifications
   - Security events

### Alerts
1. Error Rate Thresholds
   - High error rates
   - System failures
   - Security incidents

2. Performance Alerts
   - Slow responses
   - High latency
   - Resource usage

## Best Practices

1. Logging Guidelines
   - Use appropriate log levels
   - Include relevant context
   - Avoid sensitive data
   - Use structured formats

2. Error Handling
   - Log stack traces
   - Include error context
   - Use error boundaries
   - Handle async errors

3. Performance
   - Async logging
   - Log rotation
   - Sampling in production
   - Buffer management

## Security Considerations

1. Data Protection
   - No sensitive data in logs
   - PII data masking
   - Secure transmission
   - Access control

2. Compliance
   - GDPR compliance
   - Data retention
   - Audit requirements
   - Log encryption

## Future Enhancements

1. Advanced Features
   - Log correlation
   - Distributed tracing
   - Performance profiling
   - AI-powered analysis

2. Integration
   - APM tools
   - Monitoring services
   - Alert platforms
   - Analytics systems
