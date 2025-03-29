from typing import Any, List
from fastapi import APIRouter, Body, Depends, HTTPException, Path, Query
from sqlalchemy.orm import Session

from app import crud, schemas
from app.api import deps
from app.models import User

router = APIRouter()


@router.get("/questions", response_model=List[schemas.IcebreakerQuestion])
def read_icebreaker_questions(
    db: Session = Depends(deps.get_db),
    language: str = Query("en"),
    category: str = Query(None),
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Retrieve icebreaker questions.
    """
    if category:
        return crud.icebreaker_question.get_by_category(
            db=db,
            category=category,
            language=language,
            skip=skip,
            limit=limit
        )
    return crud.icebreaker_question.get_by_language(
        db=db,
        language=language,
        skip=skip,
        limit=limit
    )


@router.get("/questions/random", response_model=List[schemas.IcebreakerQuestion])
def get_random_questions(
    db: Session = Depends(deps.get_db),
    language: str = Query("en"),
    limit: int = Query(default=1, le=10),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get random icebreaker questions.
    """
    return crud.icebreaker_question.get_random(
        db=db,
        language=language,
        limit=limit
    )


# Admin endpoints
@router.post("/questions", response_model=schemas.IcebreakerQuestion)
def create_question(
    *,
    db: Session = Depends(deps.get_db),
    question_in: schemas.IcebreakerQuestionCreate,
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Create new icebreaker question (admin only).
    """
    return crud.icebreaker_question.create(db=db, obj_in=question_in)


@router.put("/questions/{question_id}", response_model=schemas.IcebreakerQuestion)
def update_question(
    *,
    db: Session = Depends(deps.get_db),
    question_id: int,
    question_in: schemas.IcebreakerQuestionUpdate,
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Update an icebreaker question (admin only).
    """
    question = crud.icebreaker_question.get(db=db, id=question_id)
    if not question:
        raise HTTPException(
            status_code=404,
            detail="Question not found"
        )
    question = crud.icebreaker_question.update(
        db=db,
        db_obj=question,
        obj_in=question_in
    )
    return question


@router.delete("/questions/{question_id}")
def delete_question(
    *,
    db: Session = Depends(deps.get_db),
    question_id: int,
    current_user: User = Depends(deps.get_current_active_superuser),
) -> Any:
    """
    Delete an icebreaker question (admin only).
    """
    question = crud.icebreaker_question.get(db=db, id=question_id)
    if not question:
        raise HTTPException(
            status_code=404,
            detail="Question not found"
        )
    crud.icebreaker_question.remove(db=db, id=question_id)
    return {"msg": "Question successfully deleted"}
