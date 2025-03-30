"""add swipes and chat

Revision ID: 70d5f891d3e5
Revises: 60d5f891d3e4
Create Date: 2025-03-30 15:34:09.000000

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '70d5f891d3e5'
down_revision = '60d5f891d3e4'
branch_labels = None
depends_on = None

def upgrade():
    # Создаем таблицу свайпов
    op.create_table(
        'swipes',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.Column('target_id', sa.Integer(), nullable=False),
        sa.Column('action', sa.String(), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(['target_id'], ['users.id'], ),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
        sa.PrimaryKeyConstraint('id'),
        sa.CheckConstraint("action IN ('like', 'pass', 'superlike')", name='valid_swipe_action')
    )
    # Создаем индексы для оптимизации
    op.create_index('ix_swipes_user_id', 'swipes', ['user_id'])
    op.create_index('ix_swipes_target_id', 'swipes', ['target_id'])
    op.create_index('ix_swipes_created_at', 'swipes', ['created_at'])

def downgrade():
    op.drop_index('ix_swipes_created_at')
    op.drop_index('ix_swipes_target_id')
    op.drop_index('ix_swipes_user_id')
    op.drop_table('swipes')
