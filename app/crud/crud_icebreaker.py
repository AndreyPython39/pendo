from typing import List, Optional
from sqlalchemy.orm import Session
from sqlalchemy import func

from app.crud.base import CRUDBase
from app.models.icebreaker import IcebreakerQuestion, IcebreakerAnswer
from app.schemas.icebreaker import (
    IcebreakerQuestionCreate,
    IcebreakerQuestionUpdate,
    IcebreakerAnswerCreate,
    IcebreakerAnswerUpdate
)


class CRUDIcebreakerQuestion(CRUDBase[IcebreakerQuestion, IcebreakerQuestionCreate, IcebreakerQuestionUpdate]):
    def get_by_language(
        self, db: Session, *, language: str, skip: int = 0, limit: int = 100
    ) -> List[IcebreakerQuestion]:
        return (
            db.query(IcebreakerQuestion)
            .filter(
                IcebreakerQuestion.language == language,
                IcebreakerQuestion.is_active == True
            )
            .offset(skip)
            .limit(limit)
            .all()
        )

    def get_random(
        self, db: Session, *, language: str, limit: int = 1
    ) -> List[IcebreakerQuestion]:
        return (
            db.query(IcebreakerQuestion)
            .filter(
                IcebreakerQuestion.language == language,
                IcebreakerQuestion.is_active == True
            )
            .order_by(func.random())
            .limit(limit)
            .all()
        )

    def get_by_category(
        self, db: Session, *, category: str, language: str, 
        skip: int = 0, limit: int = 100
    ) -> List[IcebreakerQuestion]:
        return (
            db.query(IcebreakerQuestion)
            .filter(
                IcebreakerQuestion.category == category,
                IcebreakerQuestion.language == language,
                IcebreakerQuestion.is_active == True
            )
            .offset(skip)
            .limit(limit)
            .all()
        )


class CRUDIcebreakerAnswer(CRUDBase[IcebreakerAnswer, IcebreakerAnswerCreate, IcebreakerAnswerUpdate]):
    def get_match_answers(
        self, db: Session, *, match_id: int
    ) -> List[IcebreakerAnswer]:
        return (
            db.query(IcebreakerAnswer)
            .filter(IcebreakerAnswer.match_id == match_id)
            .order_by(IcebreakerAnswer.created_at.asc())
            .all()
        )

    def get_user_answer(
        self, db: Session, *, match_id: int, question_id: int, user_id: int
    ) -> Optional[IcebreakerAnswer]:
        return (
            db.query(IcebreakerAnswer)
            .filter(
                IcebreakerAnswer.match_id == match_id,
                IcebreakerAnswer.question_id == question_id,
                IcebreakerAnswer.user_id == user_id
            )
            .first()
        )


icebreaker_question = CRUDIcebreakerQuestion(IcebreakerQuestion)
icebreaker_answer = CRUDIcebreakerAnswer(IcebreakerAnswer)
