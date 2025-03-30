"""add indexes and cascade

Revision ID: n4o5p6q7r8s9
Revises: m3n4o5p6q7r8
Create Date: 2025-03-30 17:19:03.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'n4o5p6q7r8s9'
down_revision = 'm3n4o5p6q7r8'
branch_labels = None
depends_on = None

def upgrade():
    # 1. Добавляем индексы для оптимизации поиска
    op.execute("""
    CREATE INDEX IF NOT EXISTS idx_icebreaker_answers_user ON icebreaker_answers (user_id);
    CREATE INDEX IF NOT EXISTS idx_tribe_members_user ON tribe_members (user_id);
    CREATE INDEX IF NOT EXISTS idx_tribe_votes_voter ON tribe_votes (voter_id);
    CREATE INDEX IF NOT EXISTS idx_user_interests_profile ON user_interests (user_profile_id);
    CREATE INDEX IF NOT EXISTS idx_story_views_viewer ON story_views (viewer_id);
    CREATE INDEX IF NOT EXISTS idx_user_profiles_user ON user_profiles (user_id);
    """)

    # 2. Обновляем внешние ключи для каскадного удаления
    op.execute("""
    ALTER TABLE icebreaker_answers 
    DROP CONSTRAINT IF EXISTS icebreaker_answers_user_id_fkey,
    ADD CONSTRAINT icebreaker_answers_user_id_fkey 
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

    ALTER TABLE tribe_members 
    DROP CONSTRAINT IF EXISTS tribe_members_user_id_fkey,
    ADD CONSTRAINT tribe_members_user_id_fkey 
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

    ALTER TABLE tribe_votes 
    DROP CONSTRAINT IF EXISTS tribe_votes_voter_id_fkey,
    ADD CONSTRAINT tribe_votes_voter_id_fkey 
    FOREIGN KEY (voter_id) REFERENCES users(id) ON DELETE CASCADE;

    ALTER TABLE user_interests 
    DROP CONSTRAINT IF EXISTS user_interests_user_profile_id_fkey,
    ADD CONSTRAINT user_interests_user_profile_id_fkey 
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(id) ON DELETE CASCADE;

    ALTER TABLE story_views 
    DROP CONSTRAINT IF EXISTS story_views_viewer_id_fkey,
    ADD CONSTRAINT story_views_viewer_id_fkey 
    FOREIGN KEY (viewer_id) REFERENCES users(id) ON DELETE CASCADE;

    ALTER TABLE user_profiles 
    DROP CONSTRAINT IF EXISTS user_profiles_user_id_fkey,
    ADD CONSTRAINT user_profiles_user_id_fkey 
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
    """)

def downgrade():
    # 1. Удаляем добавленные индексы
    op.execute("""
    DROP INDEX IF EXISTS idx_icebreaker_answers_user;
    DROP INDEX IF EXISTS idx_tribe_members_user;
    DROP INDEX IF EXISTS idx_tribe_votes_voter;
    DROP INDEX IF EXISTS idx_user_interests_profile;
    DROP INDEX IF EXISTS idx_story_views_viewer;
    DROP INDEX IF EXISTS idx_user_profiles_user;
    """)

    # 2. Возвращаем стандартные внешние ключи без каскадного удаления
    op.execute("""
    ALTER TABLE icebreaker_answers 
    DROP CONSTRAINT IF EXISTS icebreaker_answers_user_id_fkey,
    ADD CONSTRAINT icebreaker_answers_user_id_fkey 
    FOREIGN KEY (user_id) REFERENCES users(id);

    ALTER TABLE tribe_members 
    DROP CONSTRAINT IF EXISTS tribe_members_user_id_fkey,
    ADD CONSTRAINT tribe_members_user_id_fkey 
    FOREIGN KEY (user_id) REFERENCES users(id);

    ALTER TABLE tribe_votes 
    DROP CONSTRAINT IF EXISTS tribe_votes_voter_id_fkey,
    ADD CONSTRAINT tribe_votes_voter_id_fkey 
    FOREIGN KEY (voter_id) REFERENCES users(id);

    ALTER TABLE user_interests 
    DROP CONSTRAINT IF EXISTS user_interests_user_profile_id_fkey,
    ADD CONSTRAINT user_interests_user_profile_id_fkey 
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(id);

    ALTER TABLE story_views 
    DROP CONSTRAINT IF EXISTS story_views_viewer_id_fkey,
    ADD CONSTRAINT story_views_viewer_id_fkey 
    FOREIGN KEY (viewer_id) REFERENCES users(id);

    ALTER TABLE user_profiles 
    DROP CONSTRAINT IF EXISTS user_profiles_user_id_fkey,
    ADD CONSTRAINT user_profiles_user_id_fkey 
    FOREIGN KEY (user_id) REFERENCES users(id);
    """)
