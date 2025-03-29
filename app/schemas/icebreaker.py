from typing import Optional
from datetime import datetime
from pydantic import BaseModel


class IcebreakerQuestionBase(BaseModel):
    question: str
    category: Optional[str] = None
    language: str
    is_active: bool = True


class IcebreakerQuestionCreate(IcebreakerQuestionBase):
    pass


class IcebreakerQuestionUpdate(IcebreakerQuestionBase):
    question: Optional[str] = None
    category: Optional[str] = None
    language: Optional[str] = None
    is_active: Optional[bool] = None


class IcebreakerQuestionInDBBase(IcebreakerQuestionBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class IcebreakerQuestion(IcebreakerQuestionInDBBase):
    pass


class IcebreakerAnswerBase(BaseModel):
    match_id: int
    question_id: int
    user_id: int
    answer: str


class IcebreakerAnswerCreate(IcebreakerAnswerBase):
    pass


class IcebreakerAnswerUpdate(IcebreakerAnswerBase):
    answer: Optional[str] = None


class IcebreakerAnswerInDBBase(IcebreakerAnswerBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True


class IcebreakerAnswer(IcebreakerAnswerInDBBase):
    pass


# Response schemas for API
class IcebreakerQuestionWithAnswers(IcebreakerQuestion):
    answers: list[IcebreakerAnswer] = []
