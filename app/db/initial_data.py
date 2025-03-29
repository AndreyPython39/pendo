from typing import Dict, List
from sqlalchemy.orm import Session
from app import crud, schemas
from app.core.config import settings
from app.core.security import get_password_hash

# Initial superuser
FIRST_SUPERUSER = {
    "email": "admin@pendo.local",
    "password": "admin",
    "is_superuser": True,
    "profile": {
        "name": "Admin",
        "bio": "System Administrator"
    }
}

# Initial icebreaker questions (English)
INITIAL_QUESTIONS_EN = [
    {
        "question": "What's your idea of a perfect first date?",
        "category": "dating",
        "language": "en"
    },
    {
        "question": "What's the most adventurous thing you've ever done?",
        "category": "adventure",
        "language": "en"
    },
    {
        "question": "What's your favorite local dish and why?",
        "category": "food",
        "language": "en"
    }
]

# Initial icebreaker questions (Swahili)
INITIAL_QUESTIONS_SW = [
    {
        "question": "Unafikiria nini kuhusu tarehe bora ya kwanza?",
        "category": "dating",
        "language": "sw"
    },
    {
        "question": "Ni jambo gani la kusisimua zaidi ulilowahi kufanya?",
        "category": "adventure",
        "language": "sw"
    },
    {
        "question": "Ni chakula gani cha nyumbani unachopenda zaidi na kwa nini?",
        "category": "food",
        "language": "sw"
    }
]

# Initial icebreaker questions (Zulu)
INITIAL_QUESTIONS_ZU = [
    {
        "question": "Ucabanga ukuthi yini idate lokuqala eliphelele?",
        "category": "dating",
        "language": "zu"
    },
    {
        "question": "Yini into enobuqhawe kakhulu osuke wayenza?",
        "category": "adventure",
        "language": "zu"
    },
    {
        "question": "Yimuphi ukudla wakho wendawo oyithandayo futhi kungani?",
        "category": "food",
        "language": "zu"
    }
]

def init_db(db: Session) -> None:
    """Initialize database with initial data"""
    
    # Create superuser if it doesn't exist
    user = crud.user.get_by_email(db, email=FIRST_SUPERUSER["email"])
    if not user:
        user_in = schemas.UserCreate(
            email=FIRST_SUPERUSER["email"],
            password=FIRST_SUPERUSER["password"],
            is_superuser=True
        )
        user = crud.user.create(db, obj_in=user_in)
        
        # Create profile for superuser
        profile_in = schemas.ProfileCreate(**FIRST_SUPERUSER["profile"])
        crud.profile.create_with_user(db, obj_in=profile_in, user_id=user.id)

    # Create initial icebreaker questions
    for question_data in INITIAL_QUESTIONS_EN + INITIAL_QUESTIONS_SW + INITIAL_QUESTIONS_ZU:
        question = crud.icebreaker_question.get_by_text_and_language(
            db,
            text=question_data["question"],
            language=question_data["language"]
        )
        if not question:
            question_in = schemas.IcebreakerQuestionCreate(**question_data)
            crud.icebreaker_question.create(db, obj_in=question_in)

    # Initialize system settings
    settings_data = {
        "min_age": 18,
        "max_photos": 6,
        "tribe_member_limit": 100,
        "tribe_creation_cooldown_days": 30,
        "default_search_radius_km": 10,
        "max_search_radius_km": 100,
        "swipes_per_day": 100,
        "premium_swipes_per_day": 1000
    }
    
    for key, value in settings_data.items():
        setting = crud.system_setting.get_by_key(db, key=key)
        if not setting:
            setting_in = schemas.SystemSettingCreate(key=key, value=str(value))
            crud.system_setting.create(db, obj_in=setting_in)

    # Initialize score rules
    score_rules = {
        "profile_complete": 20,
        "email_verified": 50,
        "phone_verified": 50,
        "match_created": 10,
        "report_received": -50,
        "tribe_ignored": -10
    }
    
    for action, points in score_rules.items():
        rule = crud.score_rule.get_by_action(db, action=action)
        if not rule:
            rule_in = schemas.ScoreRuleCreate(action=action, points=points)
            crud.score_rule.create(db, obj_in=rule_in)
