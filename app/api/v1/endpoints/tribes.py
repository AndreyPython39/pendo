from typing import Any, List
from fastapi import APIRouter, Body, Depends, HTTPException, Path, Query
from sqlalchemy.orm import Session

from app import crud, schemas
from app.api import deps
from app.models import User

router = APIRouter()


@router.get("/", response_model=List[schemas.Tribe])
def read_tribes(
    db: Session = Depends(deps.get_db),
    skip: int = 0,
    limit: int = 100,
    status: schemas.TribeStatus = None,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Retrieve tribes.
    """
    if status:
        return crud.tribe.get_by_status(db, status=status, skip=skip, limit=limit)
    return crud.tribe.get_multi(db, skip=skip, limit=limit)


@router.post("/", response_model=schemas.Tribe)
def create_tribe(
    *,
    db: Session = Depends(deps.get_db),
    tribe_in: schemas.TribeCreate,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Create new tribe.
    """
    try:
        tribe = crud.tribe.create_with_owner(
            db=db, obj_in=tribe_in, creator_id=current_user.id
        )
    except ValueError as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
    return tribe


@router.get("/my", response_model=List[schemas.Tribe])
def read_user_tribes(
    db: Session = Depends(deps.get_db),
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Retrieve tribes where current user is a member.
    """
    return crud.tribe.get_user_tribes(
        db, user_id=current_user.id, skip=skip, limit=limit
    )


@router.get("/{tribe_id}", response_model=schemas.Tribe)
def read_tribe(
    *,
    db: Session = Depends(deps.get_db),
    tribe_id: int,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get tribe by ID.
    """
    tribe = crud.tribe.get(db=db, id=tribe_id)
    if not tribe:
        raise HTTPException(
            status_code=404,
            detail="Tribe not found"
        )
    return tribe


@router.put("/{tribe_id}", response_model=schemas.Tribe)
def update_tribe(
    *,
    db: Session = Depends(deps.get_db),
    tribe_id: int,
    tribe_in: schemas.TribeUpdate,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Update a tribe.
    """
    tribe = crud.tribe.get(db=db, id=tribe_id)
    if not tribe:
        raise HTTPException(
            status_code=404,
            detail="Tribe not found"
        )
    if tribe.creator_id != current_user.id and not current_user.is_superuser:
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )
    tribe = crud.tribe.update(db=db, db_obj=tribe, obj_in=tribe_in)
    return tribe


@router.post("/{tribe_id}/join", response_model=schemas.TribeMember)
def join_tribe(
    *,
    db: Session = Depends(deps.get_db),
    tribe_id: int,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Join a tribe.
    """
    tribe = crud.tribe.get(db=db, id=tribe_id)
    if not tribe:
        raise HTTPException(
            status_code=404,
            detail="Tribe not found"
        )
    if tribe.status != schemas.TribeStatus.active:
        raise HTTPException(
            status_code=400,
            detail="Can only join active tribes"
        )
    try:
        member = crud.tribe.add_member(
            db=db,
            tribe_id=tribe_id,
            member_in=schemas.TribeMemberCreate(
                tribe_id=tribe_id,
                user_id=current_user.id
            )
        )
    except ValueError as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
    return member


@router.post("/{tribe_id}/leave")
def leave_tribe(
    *,
    db: Session = Depends(deps.get_db),
    tribe_id: int,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Leave a tribe.
    """
    tribe = crud.tribe.get(db=db, id=tribe_id)
    if not tribe:
        raise HTTPException(
            status_code=404,
            detail="Tribe not found"
        )
    member = crud.tribe.remove_member(
        db=db, tribe_id=tribe_id, user_id=current_user.id
    )
    if not member:
        raise HTTPException(
            status_code=404,
            detail="Not a member of this tribe"
        )
    return {"msg": "Successfully left the tribe"}


@router.post("/{tribe_id}/vote", response_model=schemas.TribeVote)
def vote_for_chief(
    *,
    db: Session = Depends(deps.get_db),
    tribe_id: int,
    candidate_id: int = Body(...),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Vote for a tribe chief.
    """
    tribe = crud.tribe.get(db=db, id=tribe_id)
    if not tribe:
        raise HTTPException(
            status_code=404,
            detail="Tribe not found"
        )
    try:
        vote = crud.tribe.add_vote(
            db=db,
            vote_in=schemas.TribeVoteCreate(
                tribe_id=tribe_id,
                voter_id=current_user.id,
                candidate_id=candidate_id
            )
        )
    except ValueError as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
    return vote


@router.get("/{tribe_id}/members", response_model=List[schemas.TribeMember])
def get_tribe_members(
    *,
    db: Session = Depends(deps.get_db),
    tribe_id: int,
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get tribe members.
    """
    tribe = crud.tribe.get(db=db, id=tribe_id)
    if not tribe:
        raise HTTPException(
            status_code=404,
            detail="Tribe not found"
        )
    return crud.tribe.get_tribe_members(
        db=db, tribe_id=tribe_id, skip=skip, limit=limit
    )


# Admin endpoints
@router.post("/{tribe_id}/moderate", response_model=schemas.Tribe)
def moderate_tribe(
    *,
    db: Session = Depends(deps.get_db),
    tribe_id: int,
    status: str = Body(...),
    reason: str = Body(None),
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Moderate a tribe (admin only).
    """
    tribe = crud.tribe.get(db=db, id=tribe_id)
    if not tribe:
        raise HTTPException(
            status_code=404,
            detail="Tribe not found"
        )
    
    tribe_in = schemas.TribeUpdate(
        moderation_status=status,
        moderated_by=current_user.id
    )
    tribe = crud.tribe.update(db=db, db_obj=tribe, obj_in=tribe_in)

    # Create moderation log
    crud.moderation_log.create(
        db=db,
        obj_in=schemas.ModerationLogCreate(
            moderator_id=current_user.id,
            object_type=schemas.ModerationObject.tribe,
            object_id=tribe_id,
            action=schemas.ModerationAction.approve if status == "approved"
            else schemas.ModerationAction.reject,
            reason=reason
        )
    )

    return tribe
