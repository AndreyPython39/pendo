from typing import Any, Dict, List, Optional, Set, Union
from pydantic_settings import BaseSettings
from pydantic import PostgresDsn, SecretStr, validator, AnyHttpUrl, EmailStr
import os
from pathlib import Path


class Settings(BaseSettings):
    # App Settings
    DEBUG: bool = True
    ENVIRONMENT: str = "development"
    API_V1_PREFIX: str = "/api/v1"
    PROJECT_NAME: str = "Pendo"
    
    # Database settings
    POSTGRES_SERVER: str = "localhost"
    POSTGRES_USER: str = "pendo"
    POSTGRES_PASSWORD: str = "pendopass"
    POSTGRES_DB: str = "pendo"
    SQLALCHEMY_DATABASE_URI: Optional[PostgresDsn] = None

    @validator("SQLALCHEMY_DATABASE_URI", pre=True)
    def assemble_db_connection(cls, v: Optional[str], values: Dict[str, Any]) -> Any:
        if isinstance(v, str):
            return v
        return f"postgresql://{values.get('POSTGRES_USER')}:{values.get('POSTGRES_PASSWORD')}@{values.get('POSTGRES_SERVER')}/{values.get('POSTGRES_DB')}"

    # Security settings
    SECRET_KEY: str = "your-super-secret-key-change-this-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # Redis settings
    REDIS_URL: str = "redis://localhost:6379/0"
    REDIS_HOST: str = "localhost"
    REDIS_PORT: int = 6379
    REDIS_DB: int = 0
    REDIS_PASSWORD: Optional[str] = None
    
    # MinIO settings
    MINIO_ROOT_USER: str = "minioadmin"
    MINIO_ROOT_PASSWORD: str = "minioadmin"
    MINIO_ENDPOINT: str = "localhost:9000"
    MINIO_BUCKET_NAME: str = "pendo-storage"

    # Email settings
    SMTP_HOST: str = "smtp.mail.ru"
    SMTP_PORT: int = 465
    SMTP_USER: str = "ashadrin84@mail.ru"
    SMTP_PASSWORD: str = "4aaz5HsZHgyFeAMYHjk6"
    MAIL_FROM: EmailStr = "ashadrin84@mail.ru"
    MAIL_FROM_NAME: str = "Pendo"
    MAIL_TLS: bool = False
    MAIL_SSL: bool = True
    MAIL_USE_CREDENTIALS: bool = True
    
    # Code verification settings
    CODE_LENGTH: int = 6
    CODE_EXPIRATION_MINUTES: int = 10
    MAX_CODE_ATTEMPTS: int = 3
    CODE_COOLDOWN_MINUTES: int = 1

    class Config:
        case_sensitive = True
        env_file = os.path.join(Path(__file__).resolve().parent.parent.parent.parent, ".env")


settings = Settings()
