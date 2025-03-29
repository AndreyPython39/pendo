from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app import crud, schemas
from app.api import deps
from app.models import User
from app.core.config import settings

router = APIRouter()

@router.post("/subscribe", response_model=schemas.User)
async def activate_premium(
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Активировать премиум подписку для пользователя
    """
    # TODO: Добавить интеграцию с платежной системой
    
    user = await crud.user.set_premium(current_user, True)
    return user

@router.post("/unsubscribe", response_model=schemas.User)
async def deactivate_premium(
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Деактивировать премиум подписку
    """
    user = await crud.user.set_premium(current_user, False)
    return user

@router.get("/features", response_model=List[schemas.PremiumFeature])
async def list_premium_features(
    db: Session = Depends(deps.get_db),
):
    """
    Получить список премиум функций
    """
    return await crud.premium.list_features()

@router.get("/status", response_model=schemas.PremiumStatus)
async def get_premium_status(
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Получить статус премиум подписки пользователя
    """
    return {
        "is_premium": current_user.is_premium,
        "features_available": await crud.premium.get_available_features(current_user),
        "subscription_end_date": current_user.premium_ends_at
    }
