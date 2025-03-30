"""cleanup duplicate tables

Revision ID: m3n4o5p6q7r8
Revises: l2m3n4o5p6q7
Create Date: 2025-03-30 17:11:07.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'm3n4o5p6q7r8'
down_revision = 'l2m3n4o5p6q7'
branch_labels = None
depends_on = None

def upgrade():
    # Объединяем messages и messages_new
    op.execute("""
    -- Копируем данные из messages_new в messages, если такая таблица существует
    DO $$
    BEGIN
        IF EXISTS (
            SELECT 1 FROM information_schema.tables 
            WHERE table_name = 'messages_new'
        ) THEN
            INSERT INTO messages (match_id, sender_id, content, is_read, created_at)
            SELECT match_id, sender_id, content, is_read, created_at
            FROM messages_new
            ON CONFLICT DO NOTHING;
            
            DROP TABLE messages_new;
        END IF;
    END$$;
    """)

def downgrade():
    # В downgrade ничего не делаем, так как восстановить удаленную таблицу нельзя
    pass
