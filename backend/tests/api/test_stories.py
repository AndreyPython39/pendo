import pytest
from datetime import datetime, timedelta
from fastapi import status
from app.models.story import Story, StoryView
from app.core.security import create_access_token

def test_get_stories(client, test_db, test_user):
    # Create test stories
    story1 = Story(
        user_id=test_user.id,
        media_type="image",
        media_url="https://example.com/image1.jpg",
        expires_at=datetime.utcnow() + timedelta(hours=23)
    )
    test_db.add(story1)
    test_db.commit()

    # Create access token
    access_token = create_access_token(test_user.id)
    headers = {"Authorization": f"Bearer {access_token}"}

    # Test getting stories
    response = client.get("/stories/", headers=headers)
    assert response.status_code == status.HTTP_200_OK
    
    data = response.json()
    assert len(data["stories"]) == 1
    assert data["stories"][0]["media_url"] == "https://example.com/image1.jpg"
    assert not data["stories"][0]["is_viewed"]

def test_create_story(client, test_db, test_user):
    access_token = create_access_token(test_user.id)
    headers = {"Authorization": f"Bearer {access_token}"}

    story_data = {
        "media_type": "image",
        "media_url": "https://example.com/image2.jpg",
        "caption": "Test story"
    }

    response = client.post("/stories/", json=story_data, headers=headers)
    assert response.status_code == status.HTTP_201_CREATED
    
    data = response.json()
    assert data["media_url"] == story_data["media_url"]
    assert data["caption"] == story_data["caption"]

def test_view_story(client, test_db, test_user):
    # Create test story
    story = Story(
        user_id=test_user.id,
        media_type="image",
        media_url="https://example.com/image3.jpg",
        expires_at=datetime.utcnow() + timedelta(hours=23)
    )
    test_db.add(story)
    test_db.commit()

    access_token = create_access_token(test_user.id)
    headers = {"Authorization": f"Bearer {access_token}"}

    # View story
    response = client.post(f"/stories/{story.id}/view", headers=headers)
    assert response.status_code == status.HTTP_204_NO_CONTENT

    # Check if view was recorded
    view = test_db.query(StoryView).filter(
        StoryView.story_id == story.id,
        StoryView.viewer_id == test_user.id
    ).first()
    assert view is not None

def test_delete_story(client, test_db, test_user):
    # Create test story
    story = Story(
        user_id=test_user.id,
        media_type="image",
        media_url="https://example.com/image4.jpg",
        expires_at=datetime.utcnow() + timedelta(hours=23)
    )
    test_db.add(story)
    test_db.commit()

    access_token = create_access_token(test_user.id)
    headers = {"Authorization": f"Bearer {access_token}"}

    # Delete story
    response = client.delete(f"/stories/{story.id}", headers=headers)
    assert response.status_code == status.HTTP_204_NO_CONTENT

    # Verify story was deleted
    deleted_story = test_db.query(Story).filter(Story.id == story.id).first()
    assert deleted_story is None
