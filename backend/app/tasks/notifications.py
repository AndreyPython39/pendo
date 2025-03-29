from typing import List, Dict, Any
from app.core.celery_app import celery_app
from app.core.push_notifications import send_push
from app.models import User, Notification
import logging

logger = logging.getLogger(__name__)

@celery_app.task(
    bind=True,
    max_retries=3,
    name="app.tasks.notifications.send_push_notification"
)
def send_push_notification(
    self,
    user_id: int,
    title: str,
    body: str,
    data: Dict[str, Any] = None
) -> None:
    """
    Отправка push-уведомления пользователю
    """
    try:
        user = User.get(id=user_id)
        if not user or not user.push_token:
            logger.warning(f"Cannot send push to user {user_id}: no push token")
            return

        # Сохраняем уведомление в БД
        notification = Notification(
            user_id=user_id,
            title=title,
            body=body,
            data=data
        )
        notification.save()

        # Отправляем push
        send_push(
            token=user.push_token,
            title=title,
            body=body,
            data=data
        )

    except Exception as e:
        logger.error(f"Error sending push to user {user_id}: {str(e)}")
        self.retry(exc=e)

@celery_app.task(name="app.tasks.notifications.send_bulk_notification")
def send_bulk_notification(
    user_ids: List[int],
    title: str,
    body: str,
    data: Dict[str, Any] = None
) -> None:
    """
    Массовая отправка уведомлений
    """
    for user_id in user_ids:
        send_push_notification.delay(
            user_id=user_id,
            title=title,
            body=body,
            data=data
        )

@celery_app.task(
    bind=True,
    max_retries=2,
    name="app.tasks.notifications.process_match_notification"
)
def process_match_notification(self, match_id: int) -> None:
    """
    Обработка уведомления о новом матче
    """
    try:
        match = Match.get(id=match_id)
        if not match:
            logger.error(f"Match {match_id} not found")
            return

        # Отправляем уведомление обоим пользователям
        for user_id in [match.user1_id, match.user2_id]:
            send_push_notification.delay(
                user_id=user_id,
                title="Новый матч!",
                body="У вас появился новый матч! Начните общение прямо сейчас!",
                data={"match_id": match_id}
            )

    except Exception as e:
        logger.error(f"Error processing match notification {match_id}: {str(e)}")
        self.retry(exc=e)

@celery_app.task(
    bind=True,
    max_retries=2,
    name="app.tasks.notifications.process_message_notification"
)
def process_message_notification(self, message_id: int) -> None:
    """
    Обработка уведомления о новом сообщении
    """
    try:
        message = Message.get(id=message_id)
        if not message:
            logger.error(f"Message {message_id} not found")
            return

        # Отправляем уведомление получателю
        send_push_notification.delay(
            user_id=message.receiver_id,
            title="Новое сообщение",
            body=f"Вам пришло сообщение от {message.sender.name}",
            data={
                "match_id": message.match_id,
                "message_id": message_id
            }
        )

    except Exception as e:
        logger.error(f"Error processing message notification {message_id}: {str(e)}")
        self.retry(exc=e)
