from typing import List, Dict, Any
from app.core.celery_app import celery_app
from app.core.email import send_email
from app.core.config import settings

@celery_app.task(
    bind=True,
    max_retries=3,
    soft_time_limit=60,
    name="app.tasks.email.send_email_async"
)
def send_email_async(
    self,
    email_to: str,
    subject: str,
    template_name: str,
    template_data: Dict[str, Any] = None
) -> None:
    """
    Асинхронная отправка email
    """
    try:
        send_email(
            email_to=email_to,
            subject=subject,
            template_name=template_name,
            template_data=template_data or {}
        )
    except Exception as e:
        self.retry(exc=e, countdown=60)  # Повторить через минуту

@celery_app.task(name="app.tasks.email.send_bulk_email")
def send_bulk_email(
    emails: List[str],
    subject: str,
    template_name: str,
    template_data: Dict[str, Any] = None
) -> None:
    """
    Массовая отправка email
    """
    for email in emails:
        send_email_async.delay(
            email_to=email,
            subject=subject,
            template_name=template_name,
            template_data=template_data
        )
