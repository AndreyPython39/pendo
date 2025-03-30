"""create enum types

Revision ID: k1l2m3n4o5p6
Revises: j0k1l2m3n4o5
Create Date: 2025-03-30 17:03:45.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'k1l2m3n4o5p6'
down_revision = 'j0k1l2m3n4o5'
branch_labels = None
depends_on = None

def upgrade():
    # Создаем enum типы
    op.execute("""
    -- Создаем enum для типов подарков
    DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'gift_type') THEN
            CREATE TYPE gift_type AS ENUM ('flower', 'heart', 'star', 'diamond');
        END IF;
    END$$;

    -- Создаем enum для статуса чата
    DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'chat_status') THEN
            CREATE TYPE chat_status AS ENUM ('active', 'blocked', 'deleted');
        END IF;
    END$$;

    -- Создаем enum для типа события
    DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'event_type') THEN
            CREATE TYPE event_type AS ENUM ('match', 'message', 'gift', 'story');
        END IF;
    END$$;
    """)

    # Обновляем таблицу gifts
    op.execute("""
    DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'gifts' AND column_name = 'gift_type') THEN
            ALTER TABLE gifts ADD COLUMN gift_type_new gift_type;
            UPDATE gifts SET gift_type_new = gift_type::gift_type;
            ALTER TABLE gifts DROP COLUMN gift_type;
            ALTER TABLE gifts RENAME COLUMN gift_type_new TO gift_type;
        END IF;
    END$$;
    """)

    # Обновляем таблицу chats
    op.execute("""
    DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'chats' AND column_name = 'status') THEN
            ALTER TABLE chats ADD COLUMN status_new chat_status;
            UPDATE chats SET status_new = status::chat_status;
            ALTER TABLE chats DROP COLUMN status;
            ALTER TABLE chats RENAME COLUMN status_new TO status;
        END IF;
    END$$;
    """)

def downgrade():
    # Удаляем индексы
    op.execute("""
    DROP INDEX IF EXISTS idx_chats_users;
    DROP INDEX IF EXISTS idx_messages_chat_id_created_at;
    DROP INDEX IF EXISTS idx_gifts_created_at;
    DROP INDEX IF EXISTS idx_stories_expires_at;
    """)

    # Возвращаем старые типы данных
    op.execute("""
    -- Возвращаем тип VARCHAR для gift_type
    ALTER TABLE gifts ALTER COLUMN gift_type TYPE VARCHAR(50) USING gift_type::text;

    -- Возвращаем тип VARCHAR для chat status
    ALTER TABLE chats ALTER COLUMN status TYPE VARCHAR(20) USING status::text;
    """)

    # Удаляем enum типы
    op.execute("""
    DROP TYPE IF EXISTS gift_type;
    DROP TYPE IF EXISTS chat_status;
    DROP TYPE IF EXISTS event_type;
    """)
