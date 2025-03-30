"""create indexes

Revision ID: l2m3n4o5p6q7
Revises: k1l2m3n4o5p6
Create Date: 2025-03-30 17:04:00.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'l2m3n4o5p6q7'
down_revision = 'k1l2m3n4o5p6'
branch_labels = None
depends_on = None

def upgrade():
    # Добавляем индексы для оптимизации
    op.execute("""
    -- Составной индекс для чатов
    CREATE INDEX IF NOT EXISTS idx_chats_users ON chats (user1_id, user2_id);

    -- Индекс для поиска сообщений
    CREATE INDEX IF NOT EXISTS idx_messages_match_created_at ON messages (match_id, created_at);

    -- Индекс для поиска подарков
    CREATE INDEX IF NOT EXISTS idx_gifts_created_at ON gifts (created_at);

    -- Индекс для поиска историй
    CREATE INDEX IF NOT EXISTS idx_stories_expires_at ON stories (expires_at);
    """)

def downgrade():
    # Удаляем индексы
    op.execute("""
    DROP INDEX IF EXISTS idx_chats_users;
    DROP INDEX IF EXISTS idx_messages_match_created_at;
    DROP INDEX IF EXISTS idx_gifts_created_at;
    DROP INDEX IF EXISTS idx_stories_expires_at;
    """)
