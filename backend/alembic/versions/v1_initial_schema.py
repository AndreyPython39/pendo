"""v1 initial schema

Revision ID: v1_initial_schema
Revises: 
Create Date: 2025-03-30 17:45:06.000000

"""
from alembic import op
import sqlalchemy as sa
from geoalchemy2 import Geography

# revision identifiers, used by Alembic
revision = 'v1_initial_schema'
down_revision = None
branch_labels = None
depends_on = None

def upgrade():
    op.execute('''
    -- Создаем типы перечислений
    DO $$ BEGIN
        CREATE TYPE chat_status AS ENUM ('active', 'blocked', 'deleted');
    EXCEPTION
        WHEN duplicate_object THEN null;
    END $$;

    DO $$ BEGIN
        CREATE TYPE gift_type AS ENUM ('flower', 'heart', 'star', 'diamond');
    EXCEPTION
        WHEN duplicate_object THEN null;
    END $$;

    DO $$ BEGIN
        CREATE TYPE moderation_action AS ENUM ('approve', 'reject', 'block');
    EXCEPTION
        WHEN duplicate_object THEN null;
    END $$;

    DO $$ BEGIN
        CREATE TYPE moderation_object AS ENUM ('user', 'photo', 'tribe');
    EXCEPTION
        WHEN duplicate_object THEN null;
    END $$;

    DO $$ BEGIN
        CREATE TYPE tribe_status AS ENUM ('active', 'inactive', 'deleted');
    EXCEPTION
        WHEN duplicate_object THEN null;
    END $$;
    ''')

    # Users
    op.execute('''
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        email VARCHAR UNIQUE,
        phone VARCHAR UNIQUE,
        hashed_password VARCHAR NOT NULL,
        is_active BOOLEAN DEFAULT true,
        is_superuser BOOLEAN DEFAULT false,
        is_verified BOOLEAN DEFAULT false,
        role VARCHAR DEFAULT 'user',
        name VARCHAR,
        pendo_score INTEGER DEFAULT 0,
        avatar_url TEXT,
        last_active TIMESTAMP,
        last_tribe_created_at TIMESTAMP WITH TIME ZONE,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS user_profiles (
        id SERIAL PRIMARY KEY,
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        bio VARCHAR,
        birthdate DATE NOT NULL,
        gender VARCHAR NOT NULL,
        looking_for VARCHAR NOT NULL,
        temperament VARCHAR,
        location GEOGRAPHY(Point, 4326),
        distance DOUBLE PRECISION,
        extra_data JSON,
        moderation_status VARCHAR DEFAULT 'pending',
        moderated_by INTEGER REFERENCES users(id),
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS photos (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        url VARCHAR NOT NULL,
        is_primary BOOLEAN NOT NULL DEFAULT false,
        moderation_status VARCHAR NOT NULL DEFAULT 'pending',
        moderated_by INTEGER REFERENCES users(id),
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS user_scores (
        id SERIAL PRIMARY KEY,
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        score INTEGER DEFAULT 0,
        level VARCHAR,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Interests
    CREATE TABLE IF NOT EXISTS interests (
        id SERIAL PRIMARY KEY,
        name VARCHAR NOT NULL,
        category VARCHAR,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS user_interests (
        user_profile_id INTEGER NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
        interest_id INTEGER NOT NULL REFERENCES interests(id) ON DELETE CASCADE,
        PRIMARY KEY (user_profile_id, interest_id)
    );

    -- Matches and Messages
    CREATE TABLE IF NOT EXISTS matches (
        id SERIAL PRIMARY KEY,
        user1_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        user2_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        is_active BOOLEAN DEFAULT true,
        matched_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS messages (
        id SERIAL PRIMARY KEY,
        match_id INTEGER REFERENCES matches(id) ON DELETE CASCADE,
        sender_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        content VARCHAR NOT NULL,
        is_read BOOLEAN DEFAULT false,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS likes (
        id SERIAL PRIMARY KEY,
        from_user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        to_user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        is_super_like BOOLEAN DEFAULT false,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Chats
    CREATE TABLE IF NOT EXISTS chats (
        id SERIAL PRIMARY KEY,
        user1_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        user2_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        status chat_status DEFAULT 'active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- Gifts
    CREATE TABLE IF NOT EXISTS gifts (
        id SERIAL PRIMARY KEY,
        from_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        to_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        gift_type gift_type NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- Stories
    CREATE TABLE IF NOT EXISTS stories (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        media_type VARCHAR NOT NULL,
        media_url VARCHAR NOT NULL,
        thumbnail_url VARCHAR,
        caption VARCHAR,
        views_count INTEGER NOT NULL DEFAULT 0,
        expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS story_views (
        id SERIAL PRIMARY KEY,
        story_id INTEGER NOT NULL REFERENCES stories(id) ON DELETE CASCADE,
        viewer_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        viewed_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Tribes
    CREATE TABLE IF NOT EXISTS tribes (
        id SERIAL PRIMARY KEY,
        name VARCHAR NOT NULL,
        description VARCHAR,
        image_url VARCHAR,
        creator_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
        chief_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
        status tribe_status DEFAULT 'active',
        moderation_status VARCHAR DEFAULT 'pending',
        moderated_by INTEGER REFERENCES users(id),
        extra_data JSON,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS tribe_members (
        id SERIAL PRIMARY KEY,
        tribe_id INTEGER REFERENCES tribes(id) ON DELETE CASCADE,
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        joined_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS tribe_votes (
        id SERIAL PRIMARY KEY,
        tribe_id INTEGER REFERENCES tribes(id) ON DELETE CASCADE,
        voter_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        candidate_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        voted_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Icebreakers
    CREATE TABLE IF NOT EXISTS icebreaker_questions (
        id SERIAL PRIMARY KEY,
        question VARCHAR NOT NULL,
        category VARCHAR,
        language VARCHAR NOT NULL,
        is_active BOOLEAN NOT NULL DEFAULT true,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS icebreaker_answers (
        id SERIAL PRIMARY KEY,
        match_id INTEGER NOT NULL REFERENCES matches(id) ON DELETE CASCADE,
        question_id INTEGER NOT NULL REFERENCES icebreaker_questions(id) ON DELETE CASCADE,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        answer VARCHAR NOT NULL,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Moderation
    CREATE TABLE IF NOT EXISTS moderation_logs (
        id SERIAL PRIMARY KEY,
        moderator_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        object_type moderation_object NOT NULL,
        object_id INTEGER NOT NULL,
        action moderation_action NOT NULL,
        reason VARCHAR,
        extra_data JSONB,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    -- Индексы
    CREATE INDEX IF NOT EXISTS idx_user_profiles_user ON user_profiles(user_id);
    CREATE INDEX IF NOT EXISTS idx_photos_user ON photos(user_id);
    CREATE INDEX IF NOT EXISTS idx_user_scores_user ON user_scores(user_id);
    CREATE INDEX IF NOT EXISTS idx_matches_users ON matches(user1_id, user2_id);
    CREATE INDEX IF NOT EXISTS idx_messages_match ON messages(match_id);
    CREATE INDEX IF NOT EXISTS idx_messages_sender ON messages(sender_id);
    CREATE INDEX IF NOT EXISTS idx_likes_users ON likes(from_user_id, to_user_id);
    CREATE INDEX IF NOT EXISTS idx_chats_users ON chats(user1_id, user2_id);
    CREATE INDEX IF NOT EXISTS idx_gifts_users ON gifts(from_id, to_id);
    CREATE INDEX IF NOT EXISTS idx_stories_user ON stories(user_id);
    CREATE INDEX IF NOT EXISTS idx_story_views_viewer ON story_views(viewer_id);
    CREATE INDEX IF NOT EXISTS idx_tribes_creator ON tribes(creator_id);
    CREATE INDEX IF NOT EXISTS idx_tribes_chief ON tribes(chief_id);
    CREATE INDEX IF NOT EXISTS idx_tribe_members_user ON tribe_members(user_id);
    CREATE INDEX IF NOT EXISTS idx_tribe_votes_voter ON tribe_votes(voter_id);
    CREATE INDEX IF NOT EXISTS idx_icebreaker_answers_user ON icebreaker_answers(user_id);
    CREATE INDEX IF NOT EXISTS idx_moderation_logs_moderator ON moderation_logs(moderator_id);
    ''')

def downgrade():
    # Удаляем все таблицы в обратном порядке
    op.execute('''
    DROP TABLE IF EXISTS moderation_logs;
    DROP TABLE IF EXISTS icebreaker_answers;
    DROP TABLE IF EXISTS icebreaker_questions;
    DROP TABLE IF EXISTS tribe_votes;
    DROP TABLE IF EXISTS tribe_members;
    DROP TABLE IF EXISTS tribes;
    DROP TABLE IF EXISTS story_views;
    DROP TABLE IF EXISTS stories;
    DROP TABLE IF EXISTS gifts;
    DROP TABLE IF EXISTS chats;
    DROP TABLE IF EXISTS likes;
    DROP TABLE IF EXISTS messages;
    DROP TABLE IF EXISTS matches;
    DROP TABLE IF EXISTS user_interests;
    DROP TABLE IF EXISTS interests;
    DROP TABLE IF EXISTS user_scores;
    DROP TABLE IF EXISTS photos;
    DROP TABLE IF EXISTS user_profiles;
    DROP TABLE IF EXISTS users;

    DROP TYPE IF EXISTS chat_status;
    DROP TYPE IF EXISTS gift_type;
    DROP TYPE IF EXISTS moderation_action;
    DROP TYPE IF EXISTS moderation_object;
    DROP TYPE IF EXISTS tribe_status;
    ''')
