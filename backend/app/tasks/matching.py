from typing import List, Dict
from app.core.celery_app import celery_app
from app.models import User, Match, UserPreference
from app.core.matching import calculate_compatibility
import logging

logger = logging.getLogger(__name__)

@celery_app.task(
    bind=True,
    max_retries=3,
    name="app.tasks.matching.process_daily_matches"
)
def process_daily_matches(self) -> None:
    """
    Ежедневная обработка матчей для всех активных пользователей
    """
    try:
        # Получаем всех активных пользователей
        active_users = User.filter(is_active=True, last_active__gte="now() - interval '7 days'")
        
        for user in active_users:
            generate_matches_for_user.delay(user.id)

    except Exception as e:
        logger.error(f"Error processing daily matches: {str(e)}")
        self.retry(exc=e)

@celery_app.task(
    bind=True,
    max_retries=2,
    name="app.tasks.matching.generate_matches_for_user"
)
def generate_matches_for_user(self, user_id: int, limit: int = 20) -> None:
    """
    Генерация матчей для конкретного пользователя
    """
    try:
        user = User.get(id=user_id)
        if not user:
            logger.error(f"User {user_id} not found")
            return

        # Получаем предпочтения пользователя
        preferences = UserPreference.get(user_id=user_id)
        if not preferences:
            logger.warning(f"No preferences found for user {user_id}")
            return

        # Получаем потенциальных кандидатов
        candidates = User.find_potential_matches(
            user_id=user_id,
            preferences=preferences,
            limit=limit * 2  # Берем с запасом
        )

        # Вычисляем совместимость с каждым кандидатом
        matches = []
        for candidate in candidates:
            compatibility = calculate_compatibility(user, candidate)
            if compatibility >= settings.MIN_COMPATIBILITY_SCORE:
                matches.append({
                    "user_id": candidate.id,
                    "score": compatibility
                })

        # Сортируем по совместимости и берем лучших
        matches.sort(key=lambda x: x["score"], reverse=True)
        top_matches = matches[:limit]

        # Сохраняем матчи
        for match in top_matches:
            Match.create(
                user1_id=user_id,
                user2_id=match["user_id"],
                compatibility_score=match["score"]
            )

    except Exception as e:
        logger.error(f"Error generating matches for user {user_id}: {str(e)}")
        self.retry(exc=e)

@celery_app.task(
    bind=True,
    max_retries=2,
    name="app.tasks.matching.update_user_preferences"
)
def update_user_preferences(self, user_id: int) -> None:
    """
    Обновление предпочтений пользователя на основе его действий
    """
    try:
        user = User.get(id=user_id)
        if not user:
            logger.error(f"User {user_id} not found")
            return

        # Анализируем лайки пользователя
        liked_profiles = User.get_liked_profiles(user_id)
        if not liked_profiles:
            return

        # Обновляем предпочтения на основе анализа
        preferences = UserPreference.get(user_id=user_id)
        if preferences:
            new_preferences = analyze_preferences(liked_profiles)
            preferences.update(new_preferences)

    except Exception as e:
        logger.error(f"Error updating preferences for user {user_id}: {str(e)}")
        self.retry(exc=e)

@celery_app.task(
    bind=True,
    max_retries=2,
    name="app.tasks.matching.cleanup_expired_matches"
)
def cleanup_expired_matches(self) -> None:
    """
    Очистка устаревших матчей
    """
    try:
        # Удаляем матчи без взаимности старше 30 дней
        Match.delete_where(
            "created_at < now() - interval '30 days' AND NOT is_mutual"
        )

        # Архивируем неактивные взаимные матчи
        Match.archive_where(
            "last_message_at < now() - interval '90 days' AND is_mutual"
        )

    except Exception as e:
        logger.error(f"Error cleaning up expired matches: {str(e)}")
        self.retry(exc=e)
