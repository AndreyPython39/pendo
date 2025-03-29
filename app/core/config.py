from typing import Any, Dict, List, Optional, Set, Union
from pydantic_settings import BaseSettings
from pydantic import PostgresDsn, validator, SecretStr


class Settings(BaseSettings):
    API_V1_PREFIX: str = "/api/v1"
    PROJECT_NAME: str = "Pendo"
    
    # Environment and debug settings
    DEBUG: bool = True
    ENVIRONMENT: str = "development"
    ALLOWED_HOSTS: List[str] = ["*"]
    
    # Database settings
    POSTGRES_SERVER: str
    POSTGRES_USER: str
    POSTGRES_PASSWORD: SecretStr
    POSTGRES_DB: str
    SQLALCHEMY_DATABASE_URI: Optional[PostgresDsn] = None

    @validator("SQLALCHEMY_DATABASE_URI", pre=True)
    def assemble_db_connection(cls, v: Optional[str], values: Dict[str, Any]) -> Any:
        if isinstance(v, str):
            return v
        return PostgresDsn.build(
            scheme="postgresql",
            username=values.get("POSTGRES_USER"),
            password=values.get("POSTGRES_PASSWORD").get_secret_value(),
            host=values.get("POSTGRES_SERVER"),
            path=f"/{values.get('POSTGRES_DB')}"
        )

    # Security settings
    SECRET_KEY: SecretStr
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 8  # 8 days
    REFRESH_TOKEN_EXPIRE_DAYS: int = 30
    ALGORITHM: str = "HS256"
    
    # CORS settings
    BACKEND_CORS_ORIGINS: List[str] = []
    
    # Rate limiting
    RATE_LIMIT_DEFAULT: int = 60  # requests per minute
    RATE_LIMIT_AUTH: int = 5      # auth requests per minute
    RATE_LIMIT_SWIPE: int = 30    # swipes per minute
    RATE_LIMIT_WHITELIST: Set[str] = set()  # IPs exempt from rate limiting
    
    # Redis settings
    REDIS_HOST: str = "redis"
    REDIS_PORT: int = 6379
    REDIS_DB: int = 0
    REDIS_PASSWORD: Optional[SecretStr] = None
    REDIS_URL: str = "redis://localhost:6379/0"
    
    # Monitoring
    SENTRY_DSN: Optional[str] = None
    ENABLE_METRICS: bool = True
    
    # MinIO settings
    MINIO_ROOT_USER: str
    MINIO_ROOT_PASSWORD: SecretStr
    MINIO_ENDPOINT: str
    MINIO_BUCKET_NAME: str
    MINIO_SECURE: bool = True
    
    # Firebase settings (optional)
    FIREBASE_CREDENTIALS: Optional[Dict[str, Any]] = None
    FIREBASE_APP_ID: Optional[str] = None
    
    # reCAPTCHA settings
    RECAPTCHA_SITE_KEY: Optional[str] = None
    RECAPTCHA_SECRET_KEY: Optional[SecretStr] = None
    RECAPTCHA_ENABLED: bool = True
    
    # Email settings
    SMTP_TLS: bool = True
    SMTP_PORT: Optional[int] = None
    SMTP_HOST: Optional[str] = None
    SMTP_USER: Optional[str] = None
    SMTP_PASSWORD: Optional[SecretStr] = None
    EMAILS_FROM_EMAIL: Optional[str] = None
    EMAILS_FROM_NAME: Optional[str] = None
    
    # SMS settings
    SMS_PROVIDER: Optional[str] = None
    SMS_API_KEY: Optional[SecretStr] = None
    
    # Logging
    LOG_LEVEL: str = "INFO"
    LOG_FORMAT: str = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    
    # Content security
    MAX_UPLOAD_SIZE: int = 10 * 1024 * 1024  # 10MB
    ALLOWED_IMAGE_TYPES: Set[str] = {"image/jpeg", "image/png"}
    CONTENT_SECURITY_POLICY: str = "default-src 'self'; img-src 'self' data: https:; style-src 'self' 'unsafe-inline'"
    
    # Cache settings
    CACHE_ENABLED: bool = True
    CACHE_TTL: int = 60 * 5  # 5 minutes
    DEFAULT_CACHE_EXPIRE: int = 300  # 5 minutes
    
    # Rate limiting
    RATE_LIMIT_ENABLED: bool = True
    RATE_LIMIT_DEFAULT: str = "100/minute"
    
    # AWS
    AWS_ACCESS_KEY_ID: Optional[str] = None
    AWS_SECRET_ACCESS_KEY: Optional[str] = None
    AWS_REGION: str = "us-east-1"
    S3_BUCKET: Optional[str] = None
    
    # Moderation
    AUTO_APPROVE_TRUSTED_USERS: bool = False
    MODERATION_QUEUE_LIMIT: int = 1000
    
    # Feature flags
    ENABLE_FIREBASE_AUTH: bool = False
    ENABLE_EMAIL_VERIFICATION: bool = True
    ENABLE_PHONE_VERIFICATION: bool = True
    ENABLE_2FA: bool = False
    
    class Config:
        case_sensitive = True
        env_file = ".env"
        extra = "allow"

    @validator("BACKEND_CORS_ORIGINS", pre=True)
    def assemble_cors_origins(cls, v: Union[str, List[str]]) -> Union[List[str], str]:
        if isinstance(v, str) and not v.startswith("["):
            return [i.strip() for i in v.split(",")]
        elif isinstance(v, (list, str)):
            return v
        raise ValueError(v)

    @validator("ALLOWED_HOSTS", pre=True)
    def assemble_allowed_hosts(cls, v: Union[str, List[str]]) -> List[str]:
        if isinstance(v, str):
            return [i.strip() for i in v.split(",")]
        return v


settings = Settings()
