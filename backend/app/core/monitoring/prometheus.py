from prometheus_client import Counter, Histogram, Info, Gauge
from fastapi import FastAPI
from prometheus_client import make_asgi_app

# Metrics
REQUEST_COUNT = Counter(
    'pendo_request_total',
    'Total request count',
    ['method', 'endpoint', 'status']
)

REQUEST_LATENCY = Histogram(
    'pendo_request_latency_seconds',
    'Request latency in seconds',
    ['method', 'endpoint']
)

ACTIVE_USERS = Gauge(
    'pendo_active_users',
    'Number of currently active users'
)

MATCHES_COUNT = Counter(
    'pendo_matches_total',
    'Total number of matches'
)

MESSAGES_COUNT = Counter(
    'pendo_messages_total',
    'Total number of messages sent'
)

STORIES_COUNT = Counter(
    'pendo_stories_total',
    'Total number of stories created'
)

ERROR_COUNT = Counter(
    'pendo_errors_total',
    'Total number of errors',
    ['type']
)

APP_INFO = Info('pendo_app', 'Application information')

def init_metrics(app: FastAPI):
    # Add prometheus metrics endpoint
    metrics_app = make_asgi_app()
    app.mount("/metrics", metrics_app)
    
    # Set application info
    APP_INFO.info({
        'version': '1.0.0',
        'environment': 'production'
    })
    
    @app.middleware("http")
    async def metrics_middleware(request, call_next):
        # Track request count and latency
        method = request.method
        path = request.url.path
        
        with REQUEST_LATENCY.labels(
            method=method,
            endpoint=path
        ).time():
            response = await call_next(request)
            
        REQUEST_COUNT.labels(
            method=method,
            endpoint=path,
            status=response.status_code
        ).inc()
        
        return response

def track_error(error_type: str):
    ERROR_COUNT.labels(type=error_type).inc()

def track_match():
    MATCHES_COUNT.inc()

def track_message():
    MESSAGES_COUNT.inc()

def track_story():
    STORIES_COUNT.inc()

def update_active_users(count: int):
    ACTIVE_USERS.set(count)
