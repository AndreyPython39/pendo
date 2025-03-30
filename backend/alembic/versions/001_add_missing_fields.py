"""add missing fields

Revision ID: 002
Revises: 001
Create Date: 2025-03-29 23:54:32.000000

"""
from alembic import op
import sqlalchemy as sa
from geoalchemy2 import Geography


# revision identifiers, used by Alembic.
revision = '002'
down_revision = '001'
branch_labels = None
depends_on = None


def upgrade():
    # Add last_active to users table
    op.add_column('users', sa.Column('last_active', sa.DateTime(), nullable=True))
    
    # Add distance and location to user_profiles table
    op.add_column('user_profiles', sa.Column('distance', sa.Float(), nullable=True))
    op.add_column('user_profiles', sa.Column('location', Geography(geometry_type='POINT', srid=4326), nullable=True))
    
    # Create index for last_active
    op.create_index(op.f('ix_users_last_active'), 'users', ['last_active'], unique=False)
    
    # Create index for distance
    op.create_index(op.f('ix_user_profiles_distance'), 'user_profiles', ['distance'], unique=False)


def downgrade():
    # Remove index for distance
    op.drop_index(op.f('ix_user_profiles_distance'), table_name='user_profiles')
    
    # Remove index for last_active
    op.drop_index(op.f('ix_users_last_active'), table_name='users')
    
    # Remove distance and location from user_profiles table
    op.drop_column('user_profiles', 'distance')
    op.drop_column('user_profiles', 'location')
    
    # Remove last_active from users table
    op.drop_column('users', 'last_active')
