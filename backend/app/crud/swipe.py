from typing import List, Optional, Tuple
from sqlalchemy.orm import Session
from sqlalchemy import and_, or_

from app.models.swipe import Swipe
from app.schemas.swipe import SwipeCreate
from app.models.user import User

def create_swipe(db: Session, user_id: int, swipe: SwipeCreate) -> Tuple[Swipe, bool]:
    """
    Create a new swipe and check if it's a match
    Returns: (swipe, is_match)
    """
    db_swipe = Swipe(
        user_id=user_id,
        target_id=swipe.target_id,
        action=swipe.action
    )
    db.add(db_swipe)
    
    # If this is a like or superlike, check for mutual like
    is_match = False
    if swipe.action in ['like', 'superlike']:
        # Check if target user has already liked current user
        target_swipe = db.query(Swipe).filter(
            and_(
                Swipe.user_id == swipe.target_id,
                Swipe.target_id == user_id,
                Swipe.action.in_(['like', 'superlike'])
            )
        ).first()
        is_match = target_swipe is not None

    db.commit()
    db.refresh(db_swipe)
    return db_swipe, is_match

def get_user_swipes(
    db: Session,
    user_id: int,
    skip: int = 0,
    limit: int = 100
) -> List[Swipe]:
    """Get all swipes made by a user"""
    return db.query(Swipe).filter(Swipe.user_id == user_id)\
             .offset(skip).limit(limit).all()

def get_received_swipes(
    db: Session,
    user_id: int,
    skip: int = 0,
    limit: int = 100
) -> List[Swipe]:
    """Get all swipes received by a user"""
    return db.query(Swipe).filter(Swipe.target_id == user_id)\
             .offset(skip).limit(limit).all()

def get_matches(
    db: Session,
    user_id: int,
    skip: int = 0,
    limit: int = 100
) -> List[Tuple[User, Swipe]]:
    """
    Get all matches for a user (mutual likes)
    Returns list of (matched_user, swipe) tuples
    """
    # Find all mutual likes
    mutual_likes = db.query(Swipe, User).join(User, User.id == Swipe.target_id)\
        .filter(
            and_(
                Swipe.user_id == user_id,
                Swipe.action.in_(['like', 'superlike']),
                # Subquery to check for reciprocal like
                Swipe.target_id.in_(
                    db.query(Swipe.user_id).filter(
                        and_(
                            Swipe.target_id == user_id,
                            Swipe.action.in_(['like', 'superlike'])
                        )
                    )
                )
            )
        ).offset(skip).limit(limit).all()
    
    return mutual_likes

def has_swiped(db: Session, user_id: int, target_id: int) -> bool:
    """Check if user has already swiped on target"""
    return db.query(Swipe).filter(
        and_(
            Swipe.user_id == user_id,
            Swipe.target_id == target_id
        )
    ).first() is not None
