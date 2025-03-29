from typing import Any, List
from fastapi import APIRouter, Body, Depends, File, HTTPException, Path, Query, UploadFile
from sqlalchemy.orm import Session

from app import crud, schemas
from app.api import deps
from app.models import User
from app.core.storage import upload_photo

router = APIRouter()


@router.get("/logs", response_model=List[schemas.ModerationLog])
def read_moderation_logs(
    db: Session = Depends(deps.get_db),
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Retrieve moderation logs.
    """
    return crud.moderation_log.get_multi(db=db, skip=skip, limit=limit)


@router.get("/photos/pending", response_model=List[schemas.Photo])
def read_pending_photos(
    db: Session = Depends(deps.get_db),
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Get photos pending moderation.
    """
    return crud.photo.get_pending_photos(db=db, skip=skip, limit=limit)


@router.post("/photos/{photo_id}/moderate", response_model=schemas.Photo)
def moderate_photo(
    *,
    db: Session = Depends(deps.get_db),
    photo_id: int,
    status: str = Body(...),
    reason: str = Body(None),
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Moderate a photo.
    """
    return crud.photo.moderate_photo(
        db=db,
        photo_id=photo_id,
        moderator_id=current_user.id,
        status=status,
        reason=reason
    )


@router.post("/photos", response_model=schemas.Photo)
def upload_photo(
    *,
    db: Session = Depends(deps.get_db),
    file: UploadFile = File(...),
    is_primary: bool = Query(False),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Upload a new photo.
    """
    url = upload_photo(file)
    photo = crud.photo.create(
        db=db,
        obj_in=schemas.PhotoCreate(
            user_id=current_user.id,
            url=url,
            is_primary=is_primary
        )
    )
    return photo


@router.put("/photos/{photo_id}/primary", response_model=schemas.Photo)
def set_primary_photo(
    *,
    db: Session = Depends(deps.get_db),
    photo_id: int,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Set a photo as primary.
    """
    return crud.photo.set_primary_photo(
        db=db,
        user_id=current_user.id,
        photo_id=photo_id
    )


@router.get("/photos/{user_id}", response_model=List[schemas.Photo])
def get_user_photos(
    *,
    db: Session = Depends(deps.get_db),
    user_id: int,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get a user's photos.
    """
    return crud.photo.get_user_photos(db=db, user_id=user_id)


@router.delete("/photos/{photo_id}")
def delete_photo(
    *,
    db: Session = Depends(deps.get_db),
    photo_id: int,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Delete a photo.
    """
    photo = crud.photo.get(db=db, id=photo_id)
    if not photo:
        raise HTTPException(
            status_code=404,
            detail="Photo not found"
        )
    if photo.user_id != current_user.id and not current_user.is_superuser:
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )
    crud.photo.remove(db=db, id=photo_id)
    return {"msg": "Photo successfully deleted"}
