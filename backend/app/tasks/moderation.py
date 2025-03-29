from typing import List
from app.core.celery_app import celery_app
from app.core.security import verify_content
from app.models import User, Photo, Story
from app.core.config import settings
import logging

logger = logging.getLogger(__name__)

@celery_app.task(
    bind=True,
    max_retries=2,
    name="app.tasks.moderation.moderate_photo"
)
def moderate_photo(self, photo_id: int) -> None:
    """
    Автоматическая модерация фотографии
    """
    try:
        photo = Photo.get(id=photo_id)
        if not photo:
            logger.error(f"Photo {photo_id} not found")
            return

        # Проверка на NSFW контент
        nsfw_result = verify_content.check_nsfw(photo.url)
        if nsfw_result.is_nsfw:
            photo.status = "rejected"
            photo.rejection_reason = "NSFW content detected"
            photo.save()
            return

        # Проверка на запрещенные объекты
        objects_result = verify_content.detect_objects(photo.url)
        if any(obj in settings.PROHIBITED_OBJECTS for obj in objects_result):
            photo.status = "rejected"
            photo.rejection_reason = "Prohibited objects detected"
            photo.save()
            return

        # Если все проверки пройдены
        photo.status = "approved"
        photo.save()

    except Exception as e:
        logger.error(f"Error moderating photo {photo_id}: {str(e)}")
        self.retry(exc=e)

@celery_app.task(
    bind=True,
    max_retries=2,
    name="app.tasks.moderation.moderate_story"
)
def moderate_story(self, story_id: int) -> None:
    """
    Автоматическая модерация истории
    """
    try:
        story = Story.get(id=story_id)
        if not story:
            logger.error(f"Story {story_id} not found")
            return

        # Проверка текста
        if story.caption:
            text_result = verify_content.check_text(story.caption)
            if text_result.is_inappropriate:
                story.status = "rejected"
                story.rejection_reason = "Inappropriate text content"
                story.save()
                return

        # Проверка медиа
        if story.media_type == "image":
            media_result = verify_content.check_nsfw(story.media_url)
            if media_result.is_nsfw:
                story.status = "rejected"
                story.rejection_reason = "NSFW content detected"
                story.save()
                return

        # Если все проверки пройдены
        story.status = "approved"
        story.save()

    except Exception as e:
        logger.error(f"Error moderating story {story_id}: {str(e)}")
        self.retry(exc=e)

@celery_app.task(name="app.tasks.moderation.bulk_moderate_photos")
def bulk_moderate_photos(photo_ids: List[int]) -> None:
    """
    Массовая модерация фотографий
    """
    for photo_id in photo_ids:
        moderate_photo.delay(photo_id)

@celery_app.task(
    bind=True,
    max_retries=3,
    name="app.tasks.moderation.review_user_activity"
)
def review_user_activity(self, user_id: int) -> None:
    """
    Проверка активности пользователя на подозрительное поведение
    """
    try:
        user = User.get(id=user_id)
        if not user:
            logger.error(f"User {user_id} not found")
            return

        # Проверка на спам
        spam_score = verify_content.calculate_spam_score(user)
        if spam_score > settings.SPAM_THRESHOLD:
            user.status = "suspended"
            user.suspension_reason = "Suspicious activity detected"
            user.save()
            
            # Уведомить модераторов
            notify_moderators.delay(
                "High spam score detected",
                f"User {user.id} has spam score {spam_score}"
            )

    except Exception as e:
        logger.error(f"Error reviewing user {user_id}: {str(e)}")
        self.retry(exc=e)
