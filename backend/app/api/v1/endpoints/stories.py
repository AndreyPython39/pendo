from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime, timedelta

from app.core.deps import get_current_user, get_db
from app.models.story import Story, StoryReaction
from app.schemas.story import StoryCreate, StoryResponse
from app.core.storage import upload_file

router = APIRouter()

@router.post("/upload", response_model=StoryResponse)
async def upload_story(
    file: UploadFile = File(...),
    caption: str = None,
    current_user = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Upload a new story"""
    # Определяем тип контента
    content_type = file.content_type
    if content_type.startswith('image/'):
        story_type = 'image'
    elif content_type.startswith('video/'):
        story_type = 'video'
    else:
        raise HTTPException(status_code=400, detail="Unsupported file type")

    # Загружаем файл
    url = await upload_file(file)

    # Создаем историю
    story = Story(
        user_id=current_user.id,
        type=story_type,
        url=url,
        caption=caption,
        expires_at=datetime.utcnow() + timedelta(hours=24)
    )
    db.add(story)
    db.commit()
    db.refresh(story)
    return story

@router.get("/feed", response_model=List[StoryResponse])
def get_story_feed(
    current_user = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get active stories feed"""
    stories = db.query(Story).filter(
        Story.expires_at > datetime.utcnow()
    ).order_by(Story.created_at.desc()).all()
    return stories

@router.post("/{story_id}/react")
def react_to_story(
    story_id: str,
    reaction_type: str,
    current_user = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """React to a story"""
    story = db.query(Story).filter(Story.id == story_id).first()
    if not story:
        raise HTTPException(status_code=404, detail="Story not found")
    
    if story.expires_at < datetime.utcnow():
        raise HTTPException(status_code=400, detail="Story has expired")
    
    # Проверяем, не реагировал ли уже пользователь
    existing_reaction = db.query(StoryReaction).filter(
        StoryReaction.story_id == story_id,
        StoryReaction.user_id == current_user.id
    ).first()
    
    if existing_reaction:
        raise HTTPException(status_code=400, detail="Already reacted to this story")
    
    reaction = StoryReaction(
        story_id=story_id,
        user_id=current_user.id,
        type=reaction_type
    )
    db.add(reaction)
    
    # Увеличиваем счетчик реакций
    story.reaction_count += 1
    
    db.commit()
    return {"status": "success"}
