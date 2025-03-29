import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from app.core.config import settings
from app.tests.utils.gift import create_random_gift
from app.tests.utils.user import create_random_user
from app.tests.utils.utils import random_lower_string

def test_create_gift(client: TestClient, superuser_token_headers: dict, db: Session) -> None:
    data = {
        "name": random_lower_string(),
        "description": random_lower_string(),
        "price": 100,
        "is_premium": False,
        "is_animated": False
    }
    response = client.post(
        f"{settings.API_V1_PREFIX}/gifts/",
        headers=superuser_token_headers,
        json=data,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["name"] == data["name"]
    assert content["description"] == data["description"]
    assert content["price"] == data["price"]
    assert "id" in content

def test_read_gift(client: TestClient, normal_user_token_headers: dict, db: Session) -> None:
    gift = create_random_gift(db)
    response = client.get(
        f"{settings.API_V1_PREFIX}/gifts/{gift.id}",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["name"] == gift.name
    assert content["description"] == gift.description
    assert content["id"] == gift.id

def test_read_gifts(client: TestClient, normal_user_token_headers: dict, db: Session) -> None:
    for _ in range(3):
        create_random_gift(db)
    response = client.get(
        f"{settings.API_V1_PREFIX}/gifts/",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert len(content) >= 3

def test_send_gift(client: TestClient, normal_user_token_headers: dict, db: Session) -> None:
    gift = create_random_gift(db)
    receiver = create_random_user(db)
    response = client.post(
        f"{settings.API_V1_PREFIX}/gifts/{gift.id}/send/{receiver.id}",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["gift_id"] == gift.id
    assert content["receiver_id"] == receiver.id

def test_premium_gift_requires_premium(
    client: TestClient, normal_user_token_headers: dict, db: Session
) -> None:
    gift = create_random_gift(db, is_premium=True)
    receiver = create_random_user(db)
    response = client.post(
        f"{settings.API_V1_PREFIX}/gifts/{gift.id}/send/{receiver.id}",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 403

def test_list_received_gifts(
    client: TestClient, normal_user_token_headers: dict, db: Session
) -> None:
    response = client.get(
        f"{settings.API_V1_PREFIX}/gifts/received",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_list_sent_gifts(
    client: TestClient, normal_user_token_headers: dict, db: Session
) -> None:
    response = client.get(
        f"{settings.API_V1_PREFIX}/gifts/sent",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    assert isinstance(response.json(), list)
