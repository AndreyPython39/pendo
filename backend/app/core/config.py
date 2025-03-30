from typing import Any, Dict, List, Optional, Set, Union
from pydantic_settings import BaseSettings
from pydantic import PostgresDsn, SecretStr, validator, AnyHttpUrl
import os
from pathlib import Path


class Settings(BaseSettings):
    API_V1_PREFIX: str = "/api/v1"
    PROJECT_NAME: str = "Pendo"
    
    # Environment and debug settings
    DEBUG: bool = True
    ENVIRONMENT: str = "development"
    
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
        password = values.get("POSTGRES_PASSWORD")
        if isinstance(password, SecretStr):
            password = password.get_secret_value()
        return f"postgresql://{values.get('POSTGRES_USER')}:{password}@{values.get('POSTGRES_SERVER')}/{values.get('POSTGRES_DB')}"

    # Security settings
    SECRET_KEY: SecretStr
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # Redis settings
    REDIS_URL: str = "redis://localhost:6379/0"
    
    # MinIO settings
    MINIO_ROOT_USER: str = "minioadmin"
    MINIO_ROOT_PASSWORD: SecretStr
    MINIO_ENDPOINT: str = "localhost:9000"
    MINIO_BUCKET_NAME: str = "pendo-storage"

    class Config:
        case_sensitive = True
        env_file = os.path.join(Path(__file__).resolve().parent.parent.parent.parent, ".env")


settings = Settings()
