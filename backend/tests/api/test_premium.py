import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from app.core.config import settings
from app.tests.utils.user import create_random_user

def test_activate_premium(
    client: TestClient, normal_user_token_headers: dict, db: Session
) -> None:
    response = client.post(
        f"{settings.API_V1_PREFIX}/premium/subscribe",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["is_premium"] is True

def test_deactivate_premium(
    client: TestClient, normal_user_token_headers: dict, db: Session
) -> None:
    # First activate premium
    client.post(
        f"{settings.API_V1_PREFIX}/premium/subscribe",
        headers=normal_user_token_headers,
    )
    
    # Then deactivate
    response = client.post(
        f"{settings.API_V1_PREFIX}/premium/unsubscribe",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["is_premium"] is False

def test_get_premium_features(
    client: TestClient, normal_user_token_headers: dict, db: Session
) -> None:
    response = client.get(
        f"{settings.API_V1_PREFIX}/premium/features",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert isinstance(content, list)
    assert len(content) > 0
    for feature in content:
        assert "name" in feature
        assert "description" in feature

def test_get_premium_status(
    client: TestClient, normal_user_token_headers: dict, db: Session
) -> None:
    response = client.get(
        f"{settings.API_V1_PREFIX}/premium/status",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert "is_premium" in content
    assert "features_available" in content
    assert "subscription_end_date" in content
