from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException, status, Body
from sqlalchemy.orm import Session
from datetime import datetime

from app import crud, schemas
from app.api import deps
from app.models import User
from app.core.config import settings

router = APIRouter()

@router.post("/", response_model=schemas.Event)
async def create_event(
    *,
    db: Session = Depends(deps.get_db),
    event_in: schemas.EventCreate,
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Создать новое событие
    """
    # Проверяем права на создание события
    if not current_user.can_create_events:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not enough permissions to create events"
        )
    
    event = await crud.event.create(
        db=db,
        obj_in=event_in,
        creator_id=current_user.id
    )
    return event

@router.get("/", response_model=List[schemas.Event])
async def list_events(
    db: Session = Depends(deps.get_db),
    skip: int = 0,
    limit: int = 100,
    category: Optional[str] = None,
    start_date: Optional[datetime] = None,
    end_date: Optional[datetime] = None,
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Получить список событий с фильтрацией
    """
    return await crud.event.get_multi(
        db,
        skip=skip,
        limit=limit,
        category=category,
        start_date=start_date,
        end_date=end_date
    )

@router.get("/{event_id}", response_model=schemas.Event)
async def get_event(
    event_id: int,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Получить детали события по ID
    """
    event = await crud.event.get(db, id=event_id)
    if not event:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Event not found"
        )
    return event

@router.post("/{event_id}/join", response_model=schemas.EventParticipant)
async def join_event(
    event_id: int,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Присоединиться к событию
    """
    event = await crud.event.get(db, id=event_id)
    if not event:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Event not found"
        )
    
    if event.max_participants and event.participant_count >= event.max_participants:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Event is full"
        )
    
    participant = await crud.event.add_participant(
        db=db,
        event_id=event_id,
        user_id=current_user.id
    )
    return participant

@router.post("/{event_id}/leave")
async def leave_event(
    event_id: int,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Покинуть событие
    """
    success = await crud.event.remove_participant(
        db=db,
        event_id=event_id,
        user_id=current_user.id
    )
    if not success:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Not a participant of this event"
        )
    return {"message": "Successfully left the event"}

@router.put("/{event_id}", response_model=schemas.Event)
async def update_event(
    *,
    db: Session = Depends(deps.get_db),
    event_id: int,
    event_in: schemas.EventUpdate,
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Обновить информацию о событии
    """
    event = await crud.event.get(db, id=event_id)
    if not event:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Event not found"
        )
    if event.creator_id != current_user.id and not current_user.is_superuser:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not enough permissions"
        )
    
    event = await crud.event.update(
        db=db,
        db_obj=event,
        obj_in=event_in
    )
    return event
