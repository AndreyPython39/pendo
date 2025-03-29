from typing import List, Dict, Any, Optional
import numpy as np
from scipy.sparse import csr_matrix
from sklearn.metrics.pairwise import cosine_similarity
from app.models import User, UserPreference, Match, Message, Story
from app.core.cache import Cache
from app.core.analytics import Analytics
import logging

logger = logging.getLogger(__name__)

class RecommendationEngine:
    def __init__(self):
        self.cache = Cache()
        self.analytics = Analytics()
        
    async def get_user_recommendations(
        self,
        user_id: int,
        limit: int = 20,
        offset: int = 0
    ) -> List[Dict[str, Any]]:
        """
        Получение рекомендаций пользователей для матчинга
        """
        try:
            # Пробуем получить из кэша
            cache_key = f"recommendations:users:{user_id}:{offset}:{limit}"
            cached = await self.cache.get(cache_key)
            if cached:
                return cached
            
            # Получаем данные пользователя
            user = await User.get(id=user_id)
            if not user:
                return []
            
            # Получаем предпочтения пользователя
            preferences = await UserPreference.get(user_id=user_id)
            
            # Получаем историю взаимодействий
            interactions = await self._get_user_interactions(user_id)
            
            # Получаем кандидатов
            candidates = await self._get_candidates(user_id, preferences)
            
            # Рассчитываем рекомендации
            recommendations = await self._calculate_recommendations(
                user,
                preferences,
                interactions,
                candidates
            )
            
            # Сортируем по релевантности
            recommendations.sort(key=lambda x: x["score"], reverse=True)
            
            # Берем нужный срез
            result = recommendations[offset:offset + limit]
            
            # Кэшируем результат
            await self.cache.set(cache_key, result, expire=300)  # 5 минут
            
            return result
            
        except Exception as e:
            logger.error(f"Error getting user recommendations: {str(e)}")
            return []
    
    async def _get_user_interactions(self, user_id: int) -> Dict[str, Any]:
        """
        Получение истории взаимодействий пользователя
        """
        return {
            "likes": await Match.get_user_likes(user_id),
            "passes": await Match.get_user_passes(user_id),
            "matches": await Match.get_user_matches(user_id),
            "messages": await Message.get_user_messages(user_id)
        }
    
    async def _get_candidates(
        self,
        user_id: int,
        preferences: UserPreference
    ) -> List[User]:
        """
        Получение кандидатов для рекомендаций
        """
        # Базовая фильтрация по предпочтениям
        candidates = await User.filter(
            age__range=(preferences.min_age, preferences.max_age),
            gender__in=preferences.preferred_genders,
            is_active=True
        ).exclude(id=user_id)
        
        return candidates
    
    async def _calculate_recommendations(
        self,
        user: User,
        preferences: UserPreference,
        interactions: Dict[str, Any],
        candidates: List[User]
    ) -> List[Dict[str, Any]]:
        """
        Расчет рекомендаций на основе характеристик и взаимодействий
        """
        recommendations = []
        
        # Создаем векторы характеристик
        user_vector = self._create_feature_vector(user, preferences)
        
        for candidate in candidates:
            # Пропускаем уже просмотренных пользователей
            if candidate.id in interactions["likes"] or candidate.id in interactions["passes"]:
                continue
            
            # Создаем вектор кандидата
            candidate_vector = self._create_feature_vector(candidate)
            
            # Рассчитываем базовую совместимость
            compatibility = self._calculate_compatibility(user_vector, candidate_vector)
            
            # Учитываем дополнительные факторы
            activity_score = await self._calculate_activity_score(candidate.id)
            popularity_score = await self._calculate_popularity_score(candidate.id)
            
            # Итоговый скор
            final_score = 0.6 * compatibility + 0.2 * activity_score + 0.2 * popularity_score
            
            recommendations.append({
                "user": candidate,
                "score": final_score,
                "compatibility": compatibility,
                "activity_score": activity_score,
                "popularity_score": popularity_score
            })
        
        return recommendations
    
    def _create_feature_vector(self, user: User, preferences: Optional[UserPreference] = None) -> np.ndarray:
        """
        Создание вектора характеристик пользователя
        """
        # Базовые характеристики
        features = [
            user.age,
            len(user.interests) if user.interests else 0,
            user.location.latitude if user.location else 0,
            user.location.longitude if user.location else 0,
            len(user.photos) if user.photos else 0,
            user.is_verified,
            user.is_premium
        ]
        
        # Добавляем интересы
        interests_vector = np.zeros(100)  # Предполагаем 100 возможных интересов
        if user.interests:
            for interest in user.interests:
                interest_index = hash(interest) % 100
                interests_vector[interest_index] = 1
                
        return np.concatenate([features, interests_vector])
    
    def _calculate_compatibility(
        self,
        user_vector: np.ndarray,
        candidate_vector: np.ndarray
    ) -> float:
        """
        Расчет совместимости между векторами характеристик
        """
        similarity = cosine_similarity(
            user_vector.reshape(1, -1),
            candidate_vector.reshape(1, -1)
        )[0][0]
        
        return float(similarity)
    
    async def _calculate_activity_score(self, user_id: int) -> float:
        """
        Расчет скора активности пользователя
        """
        try:
            # Получаем метрики активности
            metrics = await self.analytics.get_user_metrics(user_id)
            
            # Учитываем различные факторы
            factors = {
                "login_frequency": 0.3,
                "message_frequency": 0.3,
                "story_frequency": 0.2,
                "profile_updates": 0.2
            }
            
            score = 0
            for factor, weight in factors.items():
                if factor in metrics:
                    score += metrics[factor] * weight
            
            return min(score, 1.0)  # Нормализуем до 1
            
        except Exception as e:
            logger.error(f"Error calculating activity score: {str(e)}")
            return 0.5  # Дефолтное значение
    
    async def _calculate_popularity_score(self, user_id: int) -> float:
        """
        Расчет скора популярности пользователя
        """
        try:
            # Получаем метрики популярности
            likes = await Match.count_likes_received(user_id)
            matches = await Match.count_matches(user_id)
            messages = await Message.count_received_messages(user_id)
            
            # Нормализуем и взвешиваем метрики
            likes_score = min(likes / 100, 1.0) * 0.4
            matches_score = min(matches / 50, 1.0) * 0.4
            messages_score = min(messages / 200, 1.0) * 0.2
            
            return likes_score + matches_score + messages_score
            
        except Exception as e:
            logger.error(f"Error calculating popularity score: {str(e)}")
            return 0.5  # Дефолтное значение

# Пример использования:
"""
engine = RecommendationEngine()

# Получение рекомендаций
recommendations = await engine.get_user_recommendations(
    user_id=123,
    limit=20,
    offset=0
)

for rec in recommendations:
    print(f"User: {rec['user'].name}")
    print(f"Score: {rec['score']}")
    print(f"Compatibility: {rec['compatibility']}")
    print(f"Activity: {rec['activity_score']}")
    print(f"Popularity: {rec['popularity_score']}")
"""
