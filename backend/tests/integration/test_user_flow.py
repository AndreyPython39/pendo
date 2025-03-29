import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session
from datetime import datetime, timedelta

from app.core.config import settings
from app.tests.utils.user import create_random_user
from app.tests.utils.utils import random_email, random_lower_string

def test_complete_user_flow(client: TestClient, db: Session) -> None:
    """
    Тест полного flow пользователя:
    1. Регистрация
    2. Подтверждение email
    3. Логин
    4. Обновление профиля
    5. Создание трибы
    6. Отправка лайков
    7. Получение матча
    8. Отправка сообщения
    9. Создание истории
    10. Отправка подарка
    """
    # 1. Регистрация
    user_data = {
        "email": random_email(),
        "password": random_lower_string(),
        "full_name": random_lower_string(),
    }
    response = client.post(
        f"{settings.API_V1_PREFIX}/auth/register",
        json=user_data,
    )
    assert response.status_code == 200
    user = response.json()
    assert user["email"] == user_data["email"]

    # 2. Подтверждение email
    response = client.post(
        f"{settings.API_V1_PREFIX}/auth/verify-email/{user['verification_token']}"
    )
    assert response.status_code == 200

    # 3. Логин
    login_data = {
        "username": user_data["email"],
        "password": user_data["password"],
    }
    response = client.post(
        f"{settings.API_V1_PREFIX}/auth/login/access-token",
        data=login_data,
    )
    assert response.status_code == 200
    tokens = response.json()
    assert "access_token" in tokens
    
    headers = {"Authorization": f"Bearer {tokens['access_token']}"}

    # 4. Обновление профиля
    profile_data = {
        "bio": random_lower_string(),
        "interests": ["music", "sports"],
        "birth_date": "1990-01-01",
    }
    response = client.put(
        f"{settings.API_V1_PREFIX}/users/me",
        headers=headers,
        json=profile_data,
    )
    assert response.status_code == 200
    assert response.json()["bio"] == profile_data["bio"]

    # 5. Создание трибы
    tribe_data = {
        "name": random_lower_string(),
        "description": random_lower_string(),
        "rules": random_lower_string(),
    }
    response = client.post(
        f"{settings.API_V1_PREFIX}/tribes",
        headers=headers,
        json=tribe_data,
    )
    assert response.status_code == 200
    tribe = response.json()
    assert tribe["name"] == tribe_data["name"]

    # 6. Отправка лайков
    other_user = create_random_user(db)
    response = client.post(
        f"{settings.API_V1_PREFIX}/matches/{other_user.id}/like",
        headers=headers,
    )
    assert response.status_code == 200

    # 7. Получение матча (симулируем ответный лайк)
    client.post(
        f"{settings.API_V1_PREFIX}/matches/{user['id']}/like",
        headers={"Authorization": f"Bearer {other_user.access_token}"},
    )
    response = client.get(
        f"{settings.API_V1_PREFIX}/matches",
        headers=headers,
    )
    assert response.status_code == 200
    matches = response.json()
    assert len(matches) > 0
    match = matches[0]

    # 8. Отправка сообщения
    message_data = {
        "content": random_lower_string(),
    }
    response = client.post(
        f"{settings.API_V1_PREFIX}/messages/{match['id']}",
        headers=headers,
        json=message_data,
    )
    assert response.status_code == 200
    assert response.json()["content"] == message_data["content"]

    # 9. Создание истории
    story_data = {
        "media_type": "image",
        "media_url": "https://example.com/image.jpg",
        "caption": random_lower_string(),
    }
    response = client.post(
        f"{settings.API_V1_PREFIX}/stories",
        headers=headers,
        json=story_data,
    )
    assert response.status_code == 200
    story = response.json()
    assert story["caption"] == story_data["caption"]

    # 10. Отправка подарка
    gift_response = client.get(
        f"{settings.API_V1_PREFIX}/gifts",
        headers=headers,
    )
    assert gift_response.status_code == 200
    gifts = gift_response.json()
    assert len(gifts) > 0
    gift = gifts[0]

    response = client.post(
        f"{settings.API_V1_PREFIX}/gifts/{gift['id']}/send/{other_user.id}",
        headers=headers,
    )
    assert response.status_code == 200
