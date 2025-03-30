from typing import List, Optional, Tuple
from sqlalchemy.orm import Session
from sqlalchemy import or_, and_

from app.models.match import Match
from app.schemas.match import MatchCreate

def create_match(db: Session, match: MatchCreate) -> Match:
    db_match = Match(
        user1_id=min(match.user1_id, match.user2_id),  # Всегда храним меньший ID первым
        user2_id=max(match.user1_id, match.user2_id)   # для консистентности
    )
    db.add(db_match)
    db.commit()
    db.refresh(db_match)
    return db_match

def get_match(db: Session, match_id: int) -> Optional[Match]:
    return db.query(Match).filter(Match.id == match_id).first()

def get_match_by_users(db: Session, user1_id: int, user2_id: int) -> Optional[Match]:
    """Get match between two users if exists"""
    return db.query(Match).filter(
        or_(
            and_(Match.user1_id == user1_id, Match.user2_id == user2_id),
            and_(Match.user1_id == user2_id, Match.user2_id == user1_id)
        )
    ).first()

def get_user_matches(
    db: Session,
    user_id: int,
    skip: int = 0,
    limit: int = 100,
    active_only: bool = True
) -> Tuple[List[Match], int]:
    """Get all matches for a user"""
    query = db.query(Match).filter(
        or_(
            Match.user1_id == user_id,
            Match.user2_id == user_id
        )
    )
    
    if active_only:
        query = query.filter(Match.is_active == True)
    
    total = query.count()
    matches = query.order_by(Match.created_at.desc())\
                  .offset(skip).limit(limit).all()
    
    return matches, total

def deactivate_match(db: Session, match_id: int) -> Optional[Match]:
    """Deactivate a match (soft delete)"""
    match = get_match(db, match_id)
    if match:
        match.is_active = False
        db.commit()
        db.refresh(match)
    return match
