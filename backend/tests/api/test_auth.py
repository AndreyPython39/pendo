import pytest
from fastapi.testclient import TestClient
from app.core.security import create_access_token
from app.models.user import User

def test_login(client: TestClient, db: Session):
    # Test data
    user_data = {
        "email": "test@example.com",
        "password": "test_password",
        "full_name": "Test User"
    }
    
    # Create test user
    response = client.post("/api/v1/auth/register", json=user_data)
    assert response.status_code == 201
    
    # Test login
    login_data = {
        "email": user_data["email"],
        "password": user_data["password"]
    }
    response = client.post("/api/v1/auth/login", json=login_data)
    assert response.status_code == 200
    tokens = response.json()
    assert "access_token" in tokens
    assert "refresh_token" in tokens

def test_refresh_token(client: TestClient, auth_headers: dict):
    response = client.post(
        "/api/v1/auth/refresh",
        headers=auth_headers
    )
    assert response.status_code == 200
    tokens = response.json()
    assert "access_token" in tokens
    assert "refresh_token" in tokens

def test_get_current_user(client: TestClient, auth_headers: dict):
    response = client.get(
        "/api/v1/users/me",
        headers=auth_headers
    )
    assert response.status_code == 200
    user = response.json()
    assert user["email"] == "test@example.com"

def test_update_user(client: TestClient, auth_headers: dict):
    update_data = {
        "full_name": "Updated Name",
        "bio": "New bio"
    }
    response = client.patch(
        "/api/v1/users/me",
        headers=auth_headers,
        json=update_data
    )
    assert response.status_code == 200
    user = response.json()
    assert user["full_name"] == update_data["full_name"]
    assert user["bio"] == update_data["bio"]

def test_change_password(client: TestClient, auth_headers: dict):
    password_data = {
        "current_password": "test_password",
        "new_password": "new_password"
    }
    response = client.post(
        "/api/v1/auth/change-password",
        headers=auth_headers,
        json=password_data
    )
    assert response.status_code == 200
    
    # Test login with new password
    login_data = {
        "email": "test@example.com",
        "password": "new_password"
    }
    response = client.post("/api/v1/auth/login", json=login_data)
    assert response.status_code == 200

def test_forgot_password(client: TestClient):
    email_data = {
        "email": "test@example.com"
    }
    response = client.post(
        "/api/v1/auth/forgot-password",
        json=email_data
    )
    assert response.status_code == 200

def test_reset_password(client: TestClient):
    # Note: This would require a valid reset token
    reset_data = {
        "token": "valid_reset_token",
        "new_password": "reset_password"
    }
    response = client.post(
        "/api/v1/auth/reset-password",
        json=reset_data
    )
    assert response.status_code == 200

def test_verify_email(client: TestClient):
    # Note: This would require a valid verification token
    verify_data = {
        "token": "valid_verification_token"
    }
    response = client.post(
        "/api/v1/auth/verify-email",
        json=verify_data
    )
    assert response.status_code == 200

def test_logout(client: TestClient, auth_headers: dict):
    response = client.post(
        "/api/v1/auth/logout",
        headers=auth_headers
    )
    assert response.status_code == 200
    
    # Verify token is invalidated
    response = client.get(
        "/api/v1/users/me",
        headers=auth_headers
    )
    assert response.status_code == 401
