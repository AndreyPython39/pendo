from typing import Any, List
from fastapi import APIRouter, Body, Depends, HTTPException, Path, Query
from sqlalchemy.orm import Session

from app import crud, schemas
from app.api import deps
from app.models import User

router = APIRouter()


@router.get("/", response_model=List[schemas.Match])
def read_matches(
    db: Session = Depends(deps.get_db),
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Retrieve user's matches.
    """
    matches = crud.match.get_user_matches(
        db=db, user_id=current_user.id, skip=skip, limit=limit
    )
    return matches


@router.post("/like/{user_id}", response_model=schemas.Like)
def like_user(
    *,
    db: Session = Depends(deps.get_db),
    user_id: int,
    is_super_like: bool = Body(False),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Like a user.
    """
    if user_id == current_user.id:
        raise HTTPException(
            status_code=400,
            detail="Cannot like yourself"
        )

    target_user = crud.user.get(db=db, id=user_id)
    if not target_user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    existing_like = crud.like.get_by_users(
        db=db,
        from_user_id=current_user.id,
        to_user_id=user_id
    )
    if existing_like:
        raise HTTPException(
            status_code=400,
            detail="Already liked this user"
        )

    like_in = schemas.LikeCreate(
        from_user_id=current_user.id,
        to_user_id=user_id,
        is_super_like=is_super_like
    )
    like, match = crud.like.create_with_match_check(db=db, obj_in=like_in)

    if match:
        # Create initial icebreaker question
        question = crud.icebreaker_question.get_random(
            db=db,
            language=current_user.profile.language or "en",
            limit=1
        )[0]
        crud.icebreaker_answer.create(
            db=db,
            obj_in=schemas.IcebreakerAnswerCreate(
                match_id=match.id,
                question_id=question.id,
                user_id=current_user.id,
                answer=""  # Empty answer to be filled later
            )
        )

    return like


@router.get("/{match_id}", response_model=schemas.MatchWithMessages)
def read_match(
    *,
    db: Session = Depends(deps.get_db),
    match_id: int,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get match by ID with messages.
    """
    match = crud.match.get(db=db, id=match_id)
    if not match:
        raise HTTPException(
            status_code=404,
            detail="Match not found"
        )
    if match.user1_id != current_user.id and match.user2_id != current_user.id:
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )
    
    messages = crud.message.get_chat_messages(db=db, match_id=match_id)
    return schemas.MatchWithMessages(
        **match.__dict__,
        messages=messages
    )


@router.post("/{match_id}/message", response_model=schemas.Message)
def create_message(
    *,
    db: Session = Depends(deps.get_db),
    match_id: int,
    content: str = Body(...),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Create a new message in a match.
    """
    match = crud.match.get(db=db, id=match_id)
    if not match:
        raise HTTPException(
            status_code=404,
            detail="Match not found"
        )
    if match.user1_id != current_user.id and match.user2_id != current_user.id:
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )
    
    message = crud.message.create(
        db=db,
        obj_in=schemas.MessageCreate(
            match_id=match_id,
            sender_id=current_user.id,
            content=content
        )
    )
    return message


@router.post("/{match_id}/read")
def mark_messages_read(
    *,
    db: Session = Depends(deps.get_db),
    match_id: int,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Mark all messages in a match as read.
    """
    match = crud.match.get(db=db, id=match_id)
    if not match:
        raise HTTPException(
            status_code=404,
            detail="Match not found"
        )
    if match.user1_id != current_user.id and match.user2_id != current_user.id:
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )
    
    count = crud.message.mark_as_read(
        db=db,
        match_id=match_id,
        user_id=current_user.id
    )
    return {"msg": f"Marked {count} messages as read"}


@router.get("/{match_id}/icebreaker", response_model=schemas.IcebreakerQuestionWithAnswers)
def get_match_icebreaker(
    *,
    db: Session = Depends(deps.get_db),
    match_id: int,
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Get the icebreaker question and answers for a match.
    """
    match = crud.match.get(db=db, id=match_id)
    if not match:
        raise HTTPException(
            status_code=404,
            detail="Match not found"
        )
    if match.user1_id != current_user.id and match.user2_id != current_user.id:
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )
    
    answers = crud.icebreaker_answer.get_match_answers(db=db, match_id=match_id)
    if not answers:
        raise HTTPException(
            status_code=404,
            detail="No icebreaker question found for this match"
        )
    
    question = crud.icebreaker_question.get(db=db, id=answers[0].question_id)
    return schemas.IcebreakerQuestionWithAnswers(
        **question.__dict__,
        answers=answers
    )


@router.post("/{match_id}/icebreaker", response_model=schemas.IcebreakerAnswer)
def answer_icebreaker(
    *,
    db: Session = Depends(deps.get_db),
    match_id: int,
    answer: str = Body(...),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """
    Answer the icebreaker question for a match.
    """
    match = crud.match.get(db=db, id=match_id)
    if not match:
        raise HTTPException(
            status_code=404,
            detail="Match not found"
        )
    if match.user1_id != current_user.id and match.user2_id != current_user.id:
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )
    
    answers = crud.icebreaker_answer.get_match_answers(db=db, match_id=match_id)
    if not answers:
        raise HTTPException(
            status_code=404,
            detail="No icebreaker question found for this match"
        )
    
    user_answer = crud.icebreaker_answer.get_user_answer(
        db=db,
        match_id=match_id,
        question_id=answers[0].question_id,
        user_id=current_user.id
    )
    if not user_answer:
        raise HTTPException(
            status_code=404,
            detail="No icebreaker question found for you in this match"
        )
    
    answer_in = schemas.IcebreakerAnswerUpdate(answer=answer)
    updated_answer = crud.icebreaker_answer.update(
        db=db,
        db_obj=user_answer,
        obj_in=answer_in
    )
    return updated_answer
