"""add interests table

Revision ID: 50d5f891d3e3
Revises: 40d5f891d3e2
Create Date: 2025-03-30 15:28:37.000000

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '50d5f891d3e3'
down_revision = '40d5f891d3e2'
branch_labels = None
depends_on = None

def upgrade():
    # Создаем таблицу interests
    op.create_table(
        'interests',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('name', sa.String(), nullable=False),
        sa.Column('category', sa.String(), nullable=True),
        sa.Column('created_at', sa.DateTime(), nullable=True),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_interests_name'), 'interests', ['name'], unique=True)
    op.create_index(op.f('ix_interests_category'), 'interests', ['category'], unique=False)

    # Создаем связующую таблицу user_interests
    op.create_table(
        'user_interests',
        sa.Column('user_profile_id', sa.Integer(), nullable=False),
        sa.Column('interest_id', sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(['interest_id'], ['interests.id'], ),
        sa.ForeignKeyConstraint(['user_profile_id'], ['user_profiles.id'], ),
        sa.PrimaryKeyConstraint('user_profile_id', 'interest_id')
    )

def downgrade():
    op.drop_table('user_interests')
    op.drop_index(op.f('ix_interests_name'), table_name='interests')
    op.drop_index(op.f('ix_interests_category'), table_name='interests')
    op.drop_table('interests')
