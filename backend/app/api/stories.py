from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime, timedelta

from app.core.deps import get_db, get_current_user
from app.models.user import User
from app.models.story import Story, StoryView
from app.schemas.story import StoryCreate, StoryResponse, StoryList

router = APIRouter()

@router.get("/", response_model=StoryList)
async def get_stories(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
    skip: int = 0,
    limit: int = 100
):
    """Get stories from followed users and tribes"""
    # Get stories from followed users
    followed_stories = db.query(Story).join(
        User, Story.user_id == User.id
    ).filter(
        User.id.in_(current_user.following),
        Story.expires_at > datetime.utcnow()
    ).order_by(Story.created_at.desc())

    # Get stories from user's tribes
    tribe_stories = db.query(Story).join(
        User, Story.user_id == User.id
    ).filter(
        User.current_tribe_id.in_(current_user.tribe_ids),
        Story.expires_at > datetime.utcnow()
    ).order_by(Story.created_at.desc())

    # Combine and deduplicate stories
    all_stories = followed_stories.union(tribe_stories).offset(skip).limit(limit).all()

    # Get viewed stories
    viewed_story_ids = {
        view.story_id for view in db.query(StoryView).filter(
            StoryView.viewer_id == current_user.id
        ).all()
    }

    # Mark viewed stories
    stories = []
    for story in all_stories:
        story_dict = story.__dict__
        story_dict["is_viewed"] = story.id in viewed_story_ids
        stories.append(story_dict)

    return {"stories": stories}

@router.post("/", response_model=StoryResponse, status_code=status.HTTP_201_CREATED)
async def create_story(
    story: StoryCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Create a new story"""
    db_story = Story(
        user_id=current_user.id,
        media_type=story.media_type,
        media_url=story.media_url,
        thumbnail_url=story.thumbnail_url,
        caption=story.caption,
        expires_at=datetime.utcnow() + timedelta(hours=24)
    )
    db.add(db_story)
    db.commit()
    db.refresh(db_story)
    return db_story

@router.post("/{story_id}/view", status_code=status.HTTP_204_NO_CONTENT)
async def view_story(
    story_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Mark a story as viewed"""
    story = db.query(Story).filter(Story.id == story_id).first()
    if not story:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Story not found"
        )

    # Check if already viewed
    existing_view = db.query(StoryView).filter(
        StoryView.story_id == story_id,
        StoryView.viewer_id == current_user.id
    ).first()

    if not existing_view:
        view = StoryView(
            story_id=story_id,
            viewer_id=current_user.id
        )
        db.add(view)
        
        # Update views count
        story.views_count += 1
        
        db.commit()

@router.delete("/{story_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_story(
    story_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Delete a story"""
    story = db.query(Story).filter(
        Story.id == story_id,
        Story.user_id == current_user.id
    ).first()
    
    if not story:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Story not found or not authorized"
        )

    db.delete(story)
    db.commit()
