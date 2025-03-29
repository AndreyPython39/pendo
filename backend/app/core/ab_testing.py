from typing import Dict, Any, Optional, List
import random
from datetime import datetime
from app.core.analytics import Analytics
from app.models import User, Experiment
import logging

logger = logging.getLogger(__name__)

class ABTesting:
    def __init__(self):
        self.analytics = Analytics()
        
    async def assign_experiment(
        self,
        user_id: int,
        experiment_name: str,
        variants: List[str],
        weights: Optional[List[float]] = None
    ) -> str:
        """
        Назначение варианта эксперимента пользователю
        """
        try:
            # Проверяем, участвует ли пользователь уже в эксперименте
            existing = await Experiment.get_by_user_and_name(user_id, experiment_name)
            if existing:
                return existing.variant
            
            # Выбираем вариант
            if weights is None:
                weights = [1.0 / len(variants)] * len(variants)
            
            variant = random.choices(variants, weights=weights)[0]
            
            # Сохраняем назначение
            experiment = Experiment(
                user_id=user_id,
                name=experiment_name,
                variant=variant,
                start_date=datetime.utcnow()
            )
            await experiment.save()
            
            # Отслеживаем назначение
            await self.analytics.track_event(
                "experiment_assignment",
                user_id,
                {
                    "experiment": experiment_name,
                    "variant": variant
                }
            )
            
            return variant
            
        except Exception as e:
            logger.error(f"Error assigning experiment: {str(e)}")
            return variants[0]  # Возвращаем контрольный вариант в случае ошибки
    
    async def track_experiment_event(
        self,
        user_id: int,
        experiment_name: str,
        event_type: str,
        metadata: Dict[str, Any] = None
    ) -> None:
        """
        Отслеживание события в рамках эксперимента
        """
        try:
            experiment = await Experiment.get_by_user_and_name(user_id, experiment_name)
            if not experiment:
                return
                
            await self.analytics.track_event(
                "experiment_event",
                user_id,
                {
                    "experiment": experiment_name,
                    "variant": experiment.variant,
                    "event_type": event_type,
                    **(metadata or {})
                }
            )
            
        except Exception as e:
            logger.error(f"Error tracking experiment event: {str(e)}")
    
    async def get_experiment_results(
        self,
        experiment_name: str,
        metric_name: str,
        start_date: datetime,
        end_date: datetime
    ) -> Dict[str, Any]:
        """
        Получение результатов эксперимента
        """
        try:
            query = {
                "query": {
                    "bool": {
                        "must": [
                            {"term": {"event_type": "experiment_event"}},
                            {"term": {"properties.experiment": experiment_name}},
                            {"term": {"properties.event_type": metric_name}},
                            {"range": {
                                "timestamp": {
                                    "gte": start_date,
                                    "lte": end_date
                                }
                            }}
                        ]
                    }
                },
                "aggs": {
                    "variants": {
                        "terms": {
                            "field": "properties.variant"
                        },
                        "aggs": {
                            "unique_users": {
                                "cardinality": {
                                    "field": "user_id"
                                }
                            },
                            "conversion": {
                                "value_count": {
                                    "field": "user_id"
                                }
                            }
                        }
                    }
                }
            }
            
            result = self.es.search(
                index=settings.ELASTICSEARCH_EVENTS_INDEX,
                body=query
            )
            
            variants_data = {}
            for bucket in result["aggregations"]["variants"]["buckets"]:
                variant = bucket["key"]
                variants_data[variant] = {
                    "users": bucket["unique_users"]["value"],
                    "conversions": bucket["conversion"]["value"],
                    "conversion_rate": bucket["conversion"]["value"] / bucket["unique_users"]["value"]
                }
            
            return variants_data
            
        except Exception as e:
            logger.error(f"Error getting experiment results: {str(e)}")
            return {}

# Пример использования:
"""
ab = ABTesting()

# Назначение эксперимента
variant = await ab.assign_experiment(
    user_id=123,
    experiment_name="new_matching_algorithm",
    variants=["control", "variant_a", "variant_b"],
    weights=[0.33, 0.33, 0.34]
)

# Отслеживание события в эксперименте
await ab.track_experiment_event(
    user_id=123,
    experiment_name="new_matching_algorithm",
    event_type="match_created",
    metadata={"match_score": 0.85}
)

# Получение результатов
results = await ab.get_experiment_results(
    experiment_name="new_matching_algorithm",
    metric_name="match_created",
    start_date=datetime(2025, 1, 1),
    end_date=datetime(2025, 1, 31)
)
"""
