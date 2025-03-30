"""create tribe members table

Revision ID: a1b2c3d4e5f6
Revises: be82d5112bf0
Create Date: 2025-03-30 16:46:53.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'a1b2c3d4e5f6'
down_revision = 'be82d5112bf0'
branch_labels = None
depends_on = None

def upgrade():
    op.create_table(
        'tribe_members',
        sa.Column('tribe_id', sa.Integer(), nullable=False),
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.Column('joined_at', sa.TIMESTAMP(), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(['tribe_id'], ['tribes.id'], ondelete='CASCADE'),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('tribe_id', 'user_id')
    )
    # Создаем индексы для оптимизации
    op.create_index('idx_tribe_members_tribe_id', 'tribe_members', ['tribe_id'])
    op.create_index('idx_tribe_members_user_id', 'tribe_members', ['user_id'])

def downgrade():
    op.drop_index('idx_tribe_members_user_id')
    op.drop_index('idx_tribe_members_tribe_id')
    op.drop_table('tribe_members')
