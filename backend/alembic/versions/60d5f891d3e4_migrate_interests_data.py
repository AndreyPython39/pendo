"""migrate interests data

Revision ID: 60d5f891d3e4
Revises: 50d5f891d3e3
Create Date: 2025-03-30 15:34:09.000000

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '60d5f891d3e4'
down_revision = '50d5f891d3e3'
branch_labels = None
depends_on = None

def upgrade():
    # Создаем временную таблицу для хранения старых данных
    op.execute("""
        CREATE TEMP TABLE temp_interests AS
        SELECT id, interests
        FROM user_profiles
        WHERE interests IS NOT NULL
    """)
    
    # Удаляем старое поле interests
    op.drop_column('user_profiles', 'interests')

def downgrade():
    # Восстанавливаем поле interests
    op.add_column('user_profiles', sa.Column('interests', postgresql.JSONB(), nullable=True))
