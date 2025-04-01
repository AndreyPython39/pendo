from typing import Optional
from minio import Minio
from app.core.config import settings
import logging
from fastapi import UploadFile
import uuid
import os

logger = logging.getLogger(__name__)

class StorageService:
    def __init__(self):
        self.client = Minio(
            settings.MINIO_ENDPOINT,
            access_key=settings.MINIO_ROOT_USER,
            secret_key=settings.MINIO_ROOT_PASSWORD,
            secure=False  # Set to True in production
        )
        
        # Ensure bucket exists
        if not self.client.bucket_exists(settings.MINIO_BUCKET_NAME):
            self.client.make_bucket(settings.MINIO_BUCKET_NAME)
            logger.info(f"Created bucket: {settings.MINIO_BUCKET_NAME}")

storage = StorageService()

async def upload_file(file: UploadFile, folder: Optional[str] = None) -> str:
    """Upload a file to storage and return its URL"""
    try:
        # Generate unique filename
        ext = os.path.splitext(file.filename)[1] if file.filename else ""
        filename = f"{uuid.uuid4()}{ext}"
        
        if folder:
            filename = f"{folder}/{filename}"
        
        # Read file content
        content = await file.read()
        
        # Upload to MinIO
        storage.client.put_object(
            bucket_name=settings.MINIO_BUCKET_NAME,
            object_name=filename,
            data=content,
            length=len(content),
            content_type=file.content_type
        )
        
        # Generate URL
        url = f"http://{settings.MINIO_ENDPOINT}/{settings.MINIO_BUCKET_NAME}/{filename}"
        return url
        
    except Exception as e:
        logger.error(f"Error uploading file: {str(e)}")
        raise

async def delete_file(url: str) -> bool:
    """Delete a file from storage"""
    try:
        # Extract object name from URL
        object_name = url.split(f"{settings.MINIO_BUCKET_NAME}/")[1]
        
        # Delete from MinIO
        storage.client.remove_object(
            bucket_name=settings.MINIO_BUCKET_NAME,
            object_name=object_name
        )
        return True
        
    except Exception as e:
        logger.error(f"Error deleting file: {str(e)}")
        return False
