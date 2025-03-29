import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session
from datetime import datetime, timedelta

from app.core.config import settings
from app.tests.utils.event import create_random_event
from app.tests.utils.user import create_random_user
from app.tests.utils.utils import random_lower_string

def test_create_event(client: TestClient, normal_user_token_headers: dict, db: Session) -> None:
    data = {
        "title": random_lower_string(),
        "description": random_lower_string(),
        "start_date": (datetime.utcnow() + timedelta(days=1)).isoformat(),
        "end_date": (datetime.utcnow() + timedelta(days=2)).isoformat(),
        "location": random_lower_string(),
        "max_participants": 10,
        "category": "social"
    }
    response = client.post(
        f"{settings.API_V1_PREFIX}/events/",
        headers=normal_user_token_headers,
        json=data,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["title"] == data["title"]
    assert content["description"] == data["description"]
    assert "id" in content

def test_read_event(client: TestClient, normal_user_token_headers: dict, db: Session) -> None:
    event = create_random_event(db)
    response = client.get(
        f"{settings.API_V1_PREFIX}/events/{event.id}",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["title"] == event.title
    assert content["description"] == event.description
    assert content["id"] == event.id

def test_read_events(client: TestClient, normal_user_token_headers: dict, db: Session) -> None:
    for _ in range(3):
        create_random_event(db)
    response = client.get(
        f"{settings.API_V1_PREFIX}/events/",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert len(content) >= 3

def test_update_event(
    client: TestClient, normal_user_token_headers: dict, db: Session
) -> None:
    event = create_random_event(db)
    data = {
        "title": random_lower_string(),
        "description": random_lower_string(),
    }
    response = client.put(
        f"{settings.API_V1_PREFIX}/events/{event.id}",
        headers=normal_user_token_headers,
        json=data,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["title"] == data["title"]
    assert content["description"] == data["description"]

def test_join_event(client: TestClient, normal_user_token_headers: dict, db: Session) -> None:
    event = create_random_event(db)
    response = client.post(
        f"{settings.API_V1_PREFIX}/events/{event.id}/join",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert "id" in content
    assert content["event_id"] == event.id

def test_leave_event(client: TestClient, normal_user_token_headers: dict, db: Session) -> None:
    event = create_random_event(db)
    # First join
    client.post(
        f"{settings.API_V1_PREFIX}/events/{event.id}/join",
        headers=normal_user_token_headers,
    )
    # Then leave
    response = client.post(
        f"{settings.API_V1_PREFIX}/events/{event.id}/leave",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 200

def test_event_full(client: TestClient, normal_user_token_headers: dict, db: Session) -> None:
    event = create_random_event(db, max_participants=1)
    # First user joins
    other_user = create_random_user(db)
    client.post(
        f"{settings.API_V1_PREFIX}/events/{event.id}/join",
        headers={"Authorization": f"Bearer {other_user.id}"},
    )
    # Second user tries to join
    response = client.post(
        f"{settings.API_V1_PREFIX}/events/{event.id}/join",
        headers=normal_user_token_headers,
    )
    assert response.status_code == 400
