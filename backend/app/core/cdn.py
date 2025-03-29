from typing import Optional
import boto3
from botocore.exceptions import ClientError
from app.core.config import settings
import logging

logger = logging.getLogger(__name__)

class CDNManager:
    def __init__(self):
        self.s3_client = boto3.client(
            's3',
            aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
            aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
            region_name=settings.AWS_REGION
        )
        self.cloudfront_client = boto3.client(
            'cloudfront',
            aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
            aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
            region_name=settings.AWS_REGION
        )
        self.bucket_name = settings.S3_BUCKET
        self.cloudfront_distribution_id = settings.CLOUDFRONT_DISTRIBUTION_ID

    async def upload_file(
        self,
        file_path: str,
        content_type: str,
        public: bool = True
    ) -> Optional[str]:
        """
        Загрузка файла в S3 и получение CDN URL
        """
        try:
            # Загружаем файл в S3
            extra_args = {
                'ContentType': content_type,
                'ACL': 'public-read' if public else 'private'
            }
            
            self.s3_client.upload_file(
                file_path,
                self.bucket_name,
                file_path,
                ExtraArgs=extra_args
            )

            # Формируем CDN URL
            cdn_url = f"https://{settings.CLOUDFRONT_DOMAIN}/{file_path}"
            return cdn_url

        except ClientError as e:
            logger.error(f"Error uploading file to CDN: {str(e)}")
            return None

    async def delete_file(self, file_path: str) -> bool:
        """
        Удаление файла из S3
        """
        try:
            self.s3_client.delete_object(
                Bucket=self.bucket_name,
                Key=file_path
            )
            return True
        except ClientError as e:
            logger.error(f"Error deleting file from CDN: {str(e)}")
            return False

    async def invalidate_cache(self, paths: list[str]) -> bool:
        """
        Инвалидация кэша CloudFront
        """
        try:
            self.cloudfront_client.create_invalidation(
                DistributionId=self.cloudfront_distribution_id,
                InvalidationBatch={
                    'Paths': {
                        'Quantity': len(paths),
                        'Items': paths
                    },
                    'CallerReference': str(time.time())
                }
            )
            return True
        except ClientError as e:
            logger.error(f"Error invalidating CloudFront cache: {str(e)}")
            return False

    async def get_signed_url(
        self,
        file_path: str,
        expires_in: int = 3600
    ) -> Optional[str]:
        """
        Получение подписанного URL для приватных файлов
        """
        try:
            url = self.s3_client.generate_presigned_url(
                'get_object',
                Params={
                    'Bucket': self.bucket_name,
                    'Key': file_path
                },
                ExpiresIn=expires_in
            )
            return url
        except ClientError as e:
            logger.error(f"Error generating signed URL: {str(e)}")
            return None

# Пример использования:
"""
cdn = CDNManager()

# Загрузка публичного файла
cdn_url = await cdn.upload_file(
    'path/to/image.jpg',
    'image/jpeg',
    public=True
)

# Загрузка приватного файла
private_url = await cdn.upload_file(
    'path/to/private.pdf',
    'application/pdf',
    public=False
)

# Получение временного URL для приватного файла
signed_url = await cdn.get_signed_url('path/to/private.pdf')

# Инвалидация кэша
await cdn.invalidate_cache(['/images/*', '/profiles/*'])
"""
