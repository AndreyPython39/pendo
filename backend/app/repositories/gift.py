from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, update, delete, and_, or_
from sqlalchemy.orm import joinedload
from app.models.gift import Gift, GiftTransaction
from app.schemas.gift import GiftCreate, GiftTransactionCreate
import uuid

class GiftRepository:
    def __init__(self, session: AsyncSession):
        self._session = session

    async def create_gift(self, gift_in: GiftCreate) -> Gift:
        gift = Gift(
            id=str(uuid.uuid4()),
            name=gift_in.name,
            description=gift_in.description,
            image_url=gift_in.image_url,
            animation_url=gift_in.animation_url,
            coins=gift_in.coins,
            is_animated=gift_in.is_animated,
            is_premium=gift_in.is_premium,
            is_limited=gift_in.is_limited,
            available_until=gift_in.available_until,
            metadata=gift_in.metadata
        )
        self._session.add(gift)
        await self._session.commit()
        await self._session.refresh(gift)
        return gift

    async def get_gift(self, id: str) -> Optional[Gift]:
        result = await self._session.execute(
            select(Gift).where(Gift.id == id)
        )
        return result.scalar_one_or_none()

    async def list_gifts(
        self,
        skip: int = 0,
        limit: int = 100,
        is_premium: Optional[bool] = None,
        is_animated: Optional[bool] = None
    ) -> List[Gift]:
        query = select(Gift)

        if is_premium is not None:
            query = query.where(Gift.is_premium == is_premium)
        if is_animated is not None:
            query = query.where(Gift.is_animated == is_animated)

        query = query.offset(skip).limit(limit)
        result = await self._session.execute(query)
        return result.scalars().all()

    async def send_gift(
        self,
        transaction_in: GiftTransactionCreate
    ) -> GiftTransaction:
        transaction = GiftTransaction(
            id=str(uuid.uuid4()),
            sender_id=transaction_in.sender_id,
            receiver_id=transaction_in.receiver_id,
            gift_id=transaction_in.gift_id,
            coins=transaction_in.coins,
            message=transaction_in.message,
            is_anonymous=transaction_in.is_anonymous
        )
        self._session.add(transaction)
        await self._session.commit()
        await self._session.refresh(transaction)
        return transaction

    async def get_transaction(self, id: str) -> Optional[GiftTransaction]:
        result = await self._session.execute(
            select(GiftTransaction)
            .options(
                joinedload(GiftTransaction.sender),
                joinedload(GiftTransaction.receiver),
                joinedload(GiftTransaction.gift)
            )
            .where(GiftTransaction.id == id)
        )
        return result.scalar_one_or_none()

    async def list_transactions(
        self,
        user_id: str,
        skip: int = 0,
        limit: int = 50,
        sent: bool = True
    ) -> List[GiftTransaction]:
        query = (
            select(GiftTransaction)
            .options(
                joinedload(GiftTransaction.sender),
                joinedload(GiftTransaction.receiver),
                joinedload(GiftTransaction.gift)
            )
        )

        if sent:
            query = query.where(GiftTransaction.sender_id == user_id)
        else:
            query = query.where(GiftTransaction.receiver_id == user_id)

        query = query.order_by(GiftTransaction.sent_at.desc())
        query = query.offset(skip).limit(limit)

        result = await self._session.execute(query)
        return result.scalars().all()

    async def get_user_gift_stats(self, user_id: str) -> dict:
        # Gifts sent
        sent_result = await self._session.execute(
            select(
                func.count(GiftTransaction.id),
                func.sum(GiftTransaction.coins)
            )
            .where(GiftTransaction.sender_id == user_id)
        )
        sent_count, sent_coins = sent_result.first()

        # Gifts received
        received_result = await self._session.execute(
            select(
                func.count(GiftTransaction.id),
                func.sum(GiftTransaction.coins)
            )
            .where(GiftTransaction.receiver_id == user_id)
        )
        received_count, received_coins = received_result.first()

        return {
            "sent_count": sent_count or 0,
            "sent_coins": sent_coins or 0,
            "received_count": received_count or 0,
            "received_coins": received_coins or 0
        }
