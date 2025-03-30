"""create user interests table

Revision ID: b2c3d4e5f6g7
Revises: a1b2c3d4e5f6
Create Date: 2025-03-30 16:47:00.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'b2c3d4e5f6g7'
down_revision = 'a1b2c3d4e5f6'
branch_labels = None
depends_on = None

def upgrade():
    op.create_table(
        'user_interests',
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.Column('interest_id', sa.Integer(), nullable=False),
        sa.Column('created_at', sa.TIMESTAMP(), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
        sa.ForeignKeyConstraint(['interest_id'], ['interests.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('user_id', 'interest_id')
    )
    # Создаем индексы для оптимизации
    op.create_index('idx_user_interests_user_id', 'user_interests', ['user_id'])
    op.create_index('idx_user_interests_interest_id', 'user_interests', ['interest_id'])

def downgrade():
    op.drop_index('idx_user_interests_interest_id')
    op.drop_index('idx_user_interests_user_id')
    op.drop_table('user_interests')
