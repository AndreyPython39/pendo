import pytest
from fastapi.testclient import TestClient
from app.models.match import Match
from app.models.user import User

def test_get_matches(client: TestClient, auth_headers: dict):
    response = client.get(
        "/api/v1/matching/matches",
        headers=auth_headers
    )
    assert response.status_code == 200
    matches = response.json()
    assert isinstance(matches, list)

def test_get_cards(client: TestClient, auth_headers: dict):
    response = client.get(
        "/api/v1/matching/cards",
        headers=auth_headers
    )
    assert response.status_code == 200
    cards = response.json()
    assert isinstance(cards, list)
    assert len(cards) > 0

def test_swipe_right(client: TestClient, auth_headers: dict):
    swipe_data = {
        "user_id": "test_user_id",
        "direction": "right",
        "super_like": False
    }
    response = client.post(
        "/api/v1/matching/swipe",
        headers=auth_headers,
        json=swipe_data
    )
    assert response.status_code == 200
    result = response.json()
    assert "match" in result

def test_super_like(client: TestClient, auth_headers: dict):
    swipe_data = {
        "user_id": "test_user_id",
        "direction": "right",
        "super_like": True
    }
    response = client.post(
        "/api/v1/matching/swipe",
        headers=auth_headers,
        json=swipe_data
    )
    assert response.status_code == 200
    result = response.json()
    assert "match" in result
    assert result.get("super_like") == True

def test_get_likes(client: TestClient, auth_headers: dict):
    response = client.get(
        "/api/v1/matching/likes",
        headers=auth_headers
    )
    assert response.status_code == 200
    likes = response.json()
    assert isinstance(likes, list)

def test_unmatch(client: TestClient, auth_headers: dict):
    unmatch_data = {
        "match_id": "test_match_id"
    }
    response = client.post(
        "/api/v1/matching/unmatch",
        headers=auth_headers,
        json=unmatch_data
    )
    assert response.status_code == 200

def test_boost(client: TestClient, auth_headers: dict):
    response = client.post(
        "/api/v1/matching/boost",
        headers=auth_headers
    )
    assert response.status_code == 200
    result = response.json()
    assert "boost_end_time" in result

def test_get_preferences(client: TestClient, auth_headers: dict):
    response = client.get(
        "/api/v1/matching/preferences",
        headers=auth_headers
    )
    assert response.status_code == 200
    preferences = response.json()
    assert "age_range" in preferences
    assert "distance" in preferences
    assert "gender" in preferences

def test_update_preferences(client: TestClient, auth_headers: dict):
    preferences_data = {
        "age_range": {"min": 20, "max": 35},
        "distance": 50,
        "gender": ["female"]
    }
    response = client.put(
        "/api/v1/matching/preferences",
        headers=auth_headers,
        json=preferences_data
    )
    assert response.status_code == 200
    preferences = response.json()
    assert preferences["age_range"] == preferences_data["age_range"]
    assert preferences["distance"] == preferences_data["distance"]
    assert preferences["gender"] == preferences_data["gender"]

def test_match_score(client: TestClient, auth_headers: dict):
    score_data = {
        "user_id": "test_user_id"
    }
    response = client.post(
        "/api/v1/matching/score",
        headers=auth_headers,
        json=score_data
    )
    assert response.status_code == 200
    score = response.json()
    assert "total_score" in score
    assert "components" in score
