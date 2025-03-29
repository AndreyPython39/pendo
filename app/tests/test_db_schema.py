import pytest
from sqlalchemy.engine import Engine
from sqlalchemy import inspect, text
from app.db.session import engine
from app.models import User, Profile, Tribe, Match, Message, Photo, ModerationLog, IcebreakerQuestion

def test_all_tables_exist():
    """Test that all required tables exist in the database"""
    inspector = inspect(engine)
    tables = inspector.get_table_names()
    
    required_tables = {
        'users',
        'user_profiles',
        'tribes',
        'matches',
        'messages',
        'photos',
        'moderation_logs',
        'icebreaker_questions',
        'icebreaker_answers',
        'likes',
        'user_scores',
        'tribe_votes'
    }
    
    assert all(table in tables for table in required_tables)

def test_postgis_extension():
    """Test that PostGIS extension is installed"""
    with engine.connect() as conn:
        result = conn.execute(text("SELECT postgis_version()"))
        assert result.scalar() is not None

def test_user_table_columns():
    """Test User table structure"""
    inspector = inspect(engine)
    columns = {col['name'] for col in inspector.get_columns('users')}
    
    required_columns = {
        'id',
        'email',
        'phone',
        'hashed_password',
        'is_active',
        'is_superuser',
        'created_at',
        'updated_at'
    }
    
    assert all(col in columns for col in required_columns)

def test_profile_table_columns():
    """Test Profile table structure"""
    inspector = inspect(engine)
    columns = {col['name'] for col in inspector.get_columns('user_profiles')}
    
    required_columns = {
        'id',
        'user_id',
        'name',
        'age',
        'bio',
        'latitude',
        'longitude',
        'extra_data',
        'created_at',
        'updated_at'
    }
    
    assert all(col in columns for col in required_columns)

def test_tribe_table_columns():
    """Test Tribe table structure"""
    inspector = inspect(engine)
    columns = {col['name'] for col in inspector.get_columns('tribes')}
    
    required_columns = {
        'id',
        'name',
        'description',
        'image_url',
        'created_by',
        'status',
        'created_at',
        'updated_at'
    }
    
    assert all(col in columns for col in required_columns)

def test_match_table_columns():
    """Test Match table structure"""
    inspector = inspect(engine)
    columns = {col['name'] for col in inspector.get_columns('matches')}
    
    required_columns = {
        'id',
        'user1_id',
        'user2_id',
        'matched_at',
        'status'
    }
    
    assert all(col in columns for col in required_columns)

def test_moderation_log_table_columns():
    """Test ModerationLog table structure"""
    inspector = inspect(engine)
    columns = {col['name'] for col in inspector.get_columns('moderation_logs')}
    
    required_columns = {
        'id',
        'moderator_id',
        'object_type',
        'object_id',
        'action',
        'reason',
        'extra_data',
        'created_at'
    }
    
    assert all(col in columns for col in required_columns)

def test_foreign_keys():
    """Test that all foreign keys are properly set up"""
    inspector = inspect(engine)
    
    # Check user_profiles foreign keys
    profile_fks = inspector.get_foreign_keys('user_profiles')
    assert any(fk['referred_table'] == 'users' for fk in profile_fks)
    
    # Check tribes foreign keys
    tribe_fks = inspector.get_foreign_keys('tribes')
    assert any(fk['referred_table'] == 'users' for fk in tribe_fks)
    
    # Check matches foreign keys
    match_fks = inspector.get_foreign_keys('matches')
    assert len([fk for fk in match_fks if fk['referred_table'] == 'users']) == 2

def test_indexes():
    """Test that important indexes exist"""
    inspector = inspect(engine)
    
    # Check users indexes
    user_indexes = inspector.get_indexes('users')
    user_index_names = {idx['name'] for idx in user_indexes}
    assert 'ix_users_email' in user_index_names
    assert 'ix_users_phone' in user_index_names
    
    # Check moderation_logs indexes
    mod_indexes = inspector.get_indexes('moderation_logs')
    mod_index_names = {idx['name'] for idx in mod_indexes}
    assert 'ix_moderation_logs_object_id' in mod_index_names
    assert 'ix_moderation_logs_object_type' in mod_index_names

def test_enum_types():
    """Test that required enum types exist"""
    with engine.connect() as conn:
        enums = conn.execute(text(
            "SELECT typname FROM pg_type WHERE typtype = 'e'"
        )).fetchall()
        enum_names = {e[0] for e in enums}
        
        required_enums = {
            'tribestatus',
            'moderationaction',
            'moderationobject'
        }
        
        assert all(enum in enum_names for enum in required_enums)
