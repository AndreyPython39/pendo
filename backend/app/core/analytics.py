from datetime import datetime
from typing import Dict, Any, Optional
import json
from app.core.celery_app import celery_app
from app.core.config import settings
import logging
from elasticsearch import Elasticsearch

logger = logging.getLogger(__name__)

class Analytics:
    def __init__(self):
        self.es = Elasticsearch([settings.ELASTICSEARCH_HOST])
        
    async def track_event(
        self,
        event_type: str,
        user_id: Optional[int],
        properties: Dict[str, Any]
    ) -> None:
        """
        Отслеживание события
        """
        try:
            event_data = {
                "timestamp": datetime.utcnow(),
                "event_type": event_type,
                "user_id": user_id,
                "properties": properties
            }
            
            # Асинхронно сохраняем событие
            process_analytics_event.delay(event_data)
            
        except Exception as e:
            logger.error(f"Error tracking event: {str(e)}")

    async def track_user_action(
        self,
        user_id: int,
        action: str,
        target_id: Optional[int] = None,
        metadata: Dict[str, Any] = None
    ) -> None:
        """
        Отслеживание действия пользователя
        """
        properties = {
            "action": action,
            "target_id": target_id,
            **(metadata or {})
        }
        await self.track_event("user_action", user_id, properties)

    async def track_error(
        self,
        error_type: str,
        error_message: str,
        user_id: Optional[int] = None,
        metadata: Dict[str, Any] = None
    ) -> None:
        """
        Отслеживание ошибки
        """
        properties = {
            "error_type": error_type,
            "error_message": error_message,
            **(metadata or {})
        }
        await self.track_event("error", user_id, properties)

    async def get_user_metrics(self, user_id: int) -> Dict[str, Any]:
        """
        Получение метрик пользователя
        """
        try:
            query = {
                "query": {
                    "bool": {
                        "must": [
                            {"term": {"user_id": user_id}},
                            {"range": {
                                "timestamp": {
                                    "gte": "now-30d/d"
                                }
                            }}
                        ]
                    }
                },
                "aggs": {
                    "actions_per_day": {
                        "date_histogram": {
                            "field": "timestamp",
                            "calendar_interval": "day"
                        }
                    },
                    "action_types": {
                        "terms": {
                            "field": "properties.action"
                        }
                    }
                }
            }
            
            result = self.es.search(
                index=settings.ELASTICSEARCH_EVENTS_INDEX,
                body=query
            )
            
            return {
                "total_actions": result["hits"]["total"]["value"],
                "actions_per_day": result["aggregations"]["actions_per_day"]["buckets"],
                "action_types": result["aggregations"]["action_types"]["buckets"]
            }
            
        except Exception as e:
            logger.error(f"Error getting user metrics: {str(e)}")
            return {}

    async def get_global_metrics(self) -> Dict[str, Any]:
        """
        Получение глобальных метрик
        """
        try:
            query = {
                "query": {
                    "range": {
                        "timestamp": {
                            "gte": "now-24h/h"
                        }
                    }
                },
                "aggs": {
                    "events_per_hour": {
                        "date_histogram": {
                            "field": "timestamp",
                            "calendar_interval": "hour"
                        }
                    },
                    "event_types": {
                        "terms": {
                            "field": "event_type"
                        }
                    },
                    "active_users": {
                        "cardinality": {
                            "field": "user_id"
                        }
                    }
                }
            }
            
            result = self.es.search(
                index=settings.ELASTICSEARCH_EVENTS_INDEX,
                body=query
            )
            
            return {
                "total_events": result["hits"]["total"]["value"],
                "events_per_hour": result["aggregations"]["events_per_hour"]["buckets"],
                "event_types": result["aggregations"]["event_types"]["buckets"],
                "active_users": result["aggregations"]["active_users"]["value"]
            }
            
        except Exception as e:
            logger.error(f"Error getting global metrics: {str(e)}")
            return {}

@celery_app.task(name="app.tasks.analytics.process_analytics_event")
def process_analytics_event(event_data: Dict[str, Any]) -> None:
    """
    Обработка аналитического события
    """
    try:
        es = Elasticsearch([settings.ELASTICSEARCH_HOST])
        
        # Сохраняем в Elasticsearch
        es.index(
            index=settings.ELASTICSEARCH_EVENTS_INDEX,
            body=event_data
        )
        
        # Если это важное событие, отправляем в очередь для дальнейшей обработки
        if event_data["event_type"] in settings.IMPORTANT_EVENTS:
            process_important_event.delay(event_data)
            
    except Exception as e:
        logger.error(f"Error processing analytics event: {str(e)}")

@celery_app.task(name="app.tasks.analytics.process_important_event")
def process_important_event(event_data: Dict[str, Any]) -> None:
    """
    Обработка важного события
    """
    try:
        # Здесь может быть дополнительная логика обработки важных событий
        # Например, отправка уведомлений, обновление метрик и т.д.
        pass
    except Exception as e:
        logger.error(f"Error processing important event: {str(e)}")

# Пример использования:
"""
analytics = Analytics()

# Отслеживание действия пользователя
await analytics.track_user_action(
    user_id=123,
    action="like_profile",
    target_id=456,
    metadata={"source": "main_feed"}
)

# Отслеживание ошибки
await analytics.track_error(
    error_type="api_error",
    error_message="Failed to load profile",
    user_id=123,
    metadata={"endpoint": "/api/profiles/456"}
)

# Получение метрик пользователя
user_metrics = await analytics.get_user_metrics(123)

# Получение глобальных метрик
global_metrics = await analytics.get_global_metrics()
"""
