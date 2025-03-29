from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app import crud, schemas
from app.api import deps
from app.models import User
from app.core.config import settings

router = APIRouter()

@router.get("/", response_model=List[schemas.Gift])
async def list_gifts(
    skip: int = 0,
    limit: int = 100,
    is_premium: Optional[bool] = None,
    is_animated: Optional[bool] = None,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Получить список доступных подарков.
    Фильтрация по premium и animated статусу.
    """
    return await crud.gift.list_gifts(
        skip=skip,
        limit=limit,
        is_premium=is_premium,
        is_animated=is_animated
    )

@router.post("/{gift_id}/send/{receiver_id}", response_model=schemas.GiftTransaction)
async def send_gift(
    gift_id: int,
    receiver_id: int,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Отправить подарок другому пользователю
    """
    # Проверяем существование подарка
    gift = await crud.gift.get(gift_id)
    if not gift:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Gift not found"
        )
    
    # Проверяем существование получателя
    receiver = await crud.user.get(receiver_id)
    if not receiver:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Receiver not found"
        )
    
    # Проверяем премиум статус для премиум подарков
    if gift.is_premium and not current_user.is_premium:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Premium subscription required to send this gift"
        )
    
    # Создаем транзакцию подарка
    transaction = await crud.gift.create_transaction(
        sender_id=current_user.id,
        receiver_id=receiver_id,
        gift_id=gift_id
    )
    
    return transaction

@router.get("/received", response_model=List[schemas.GiftTransaction])
async def list_received_gifts(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Получить список полученных подарков
    """
    return await crud.gift.get_received_gifts(
        user_id=current_user.id,
        skip=skip,
        limit=limit
    )

@router.get("/sent", response_model=List[schemas.GiftTransaction])
async def list_sent_gifts(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
):
    """
    Получить список отправленных подарков
    """
    return await crud.gift.get_sent_gifts(
        user_id=current_user.id,
        skip=skip,
        limit=limit
    )
