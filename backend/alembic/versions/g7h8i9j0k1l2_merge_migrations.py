"""merge migrations

Revision ID: g7h8i9j0k1l2
Revises: 80d5f891d3e6, b2c3d4e5f6g7
Create Date: 2025-03-30 16:57:00.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'g7h8i9j0k1l2'
down_revision = ('80d5f891d3e6', 'b2c3d4e5f6g7')
branch_labels = None
depends_on = None

def upgrade():
    # Создаем enum тип для swipe action
    op.execute("""
    DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'swipe_action') THEN
            CREATE TYPE swipe_action AS ENUM ('like', 'dislike');
        END IF;
    END$$;
    """)
    
    # Обновляем тип колонки action в таблице swipes
    op.execute("""
    DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'swipes' AND column_name = 'action') THEN
            UPDATE swipes SET action = 'dislike' WHERE action = 'pass';
            ALTER TABLE swipes ALTER COLUMN action TYPE swipe_action USING action::swipe_action;
        END IF;
    END$$;
    """)

def downgrade():
    # Возвращаем тип VARCHAR для action в swipes
    op.execute("""
    DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'swipes' AND column_name = 'action') THEN
            ALTER TABLE swipes ALTER COLUMN action TYPE VARCHAR(10) USING action::text;
        END IF;
    END$$;
    """)
    
    # Удаляем enum тип
    op.execute("DROP TYPE IF EXISTS swipe_action")
