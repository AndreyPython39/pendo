"""merge message timestamps

Revision ID: p6q7r8s9t0u1
Revises: o5p6q7r8s9t0
Create Date: 2025-03-30 17:23:49.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'p6q7r8s9t0u1'
down_revision = 'o5p6q7r8s9t0'
branch_labels = None
depends_on = None

def upgrade():
    # 1. Обновляем created_at где sent_at не NULL и created_at NULL
    op.execute("""
    UPDATE messages 
    SET created_at = sent_at 
    WHERE sent_at IS NOT NULL AND created_at IS NULL;
    """)

    # 2. Удаляем колонку sent_at
    op.execute("""
    ALTER TABLE messages
    DROP COLUMN IF EXISTS sent_at;
    """)

def downgrade():
    # 1. Добавляем колонку sent_at
    op.execute("""
    ALTER TABLE messages
    ADD COLUMN sent_at timestamp with time zone;
    """)

    # 2. Копируем данные из created_at в sent_at
    op.execute("""
    UPDATE messages 
    SET sent_at = created_at;
    """)
