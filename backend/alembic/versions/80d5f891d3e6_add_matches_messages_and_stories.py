"""add matches messages and stories

Revision ID: 80d5f891d3e6
Revises: 70d5f891d3e5
Create Date: 2025-03-30 15:54:10.000000

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '80d5f891d3e6'
down_revision = '70d5f891d3e5'
branch_labels = None
depends_on = None

def upgrade():
    # Добавляем ограничение media_type для stories
    op.create_check_constraint(
        'valid_story_media_type',
        'stories',
        "media_type IN ('image', 'video')"
    )

    # Добавляем уникальное ограничение для просмотров историй
    op.create_unique_constraint(
        'unique_story_view',
        'story_views',
        ['story_id', 'viewer_id']
    )

def downgrade():
    op.drop_constraint('unique_story_view', 'story_views', type_='unique')
    op.drop_constraint('valid_story_media_type', 'stories', type_='check')
