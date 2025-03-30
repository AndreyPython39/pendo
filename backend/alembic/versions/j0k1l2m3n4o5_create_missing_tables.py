"""create missing tables

Revision ID: j0k1l2m3n4o5
Revises: i9j0k1l2m3n4
Create Date: 2025-03-30 17:03:30.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'j0k1l2m3n4o5'
down_revision = 'i9j0k1l2m3n4'
branch_labels = None
depends_on = None

def upgrade():
    # 1. Создаем таблицу chats
    op.execute("""
    CREATE TABLE IF NOT EXISTS chats (
        id SERIAL PRIMARY KEY,
        user1_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        user2_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        status VARCHAR(20) DEFAULT 'active',
        created_at TIMESTAMP DEFAULT NOW(),
        updated_at TIMESTAMP DEFAULT NOW(),
        CONSTRAINT unique_users UNIQUE (user1_id, user2_id)
    );
    """)

    # 2. Создаем таблицу messages
    op.execute("""
    CREATE TABLE IF NOT EXISTS messages (
        id SERIAL PRIMARY KEY,
        chat_id INTEGER REFERENCES chats(id) ON DELETE CASCADE,
        from_user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        message TEXT NOT NULL,
        is_read BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT NOW()
    );
    """)

    # 3. Создаем таблицу gifts
    op.execute("""
    CREATE TABLE IF NOT EXISTS gifts (
        id SERIAL PRIMARY KEY,
        from_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        to_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        gift_type VARCHAR(50),
        created_at TIMESTAMP DEFAULT NOW()
    );
    """)

    # 4. Создаем таблицу stories
    op.execute("""
    CREATE TABLE IF NOT EXISTS stories (
        id SERIAL PRIMARY KEY,
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        media_url TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT NOW(),
        expires_at TIMESTAMP NOT NULL
    );
    """)

def downgrade():
    op.execute("""
    DROP TABLE IF EXISTS messages;
    DROP TABLE IF EXISTS chats;
    DROP TABLE IF EXISTS gifts;
    DROP TABLE IF EXISTS stories;
    """)
