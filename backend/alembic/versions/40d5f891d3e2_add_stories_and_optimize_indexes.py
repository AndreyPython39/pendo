"""add_stories_and_optimize_indexes

Revision ID: 40d5f891d3e2
Revises: be82d5112bf0
Create Date: 2025-03-29 23:20:17.000000

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql
import geoalchemy2

# revision identifiers, used by Alembic.
revision = '40d5f891d3e2'
down_revision = 'be82d5112bf0'
branch_labels = None
depends_on = None


def upgrade():
    # Create stories table
    op.create_table(
        'stories',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.Column('media_type', sa.String(), nullable=False),
        sa.Column('media_url', sa.String(), nullable=False),
        sa.Column('thumbnail_url', sa.String(), nullable=True),
        sa.Column('caption', sa.String(), nullable=True),
        sa.Column('views_count', sa.Integer(), server_default='0', nullable=False),
        sa.Column('expires_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index('ix_stories_user_id', 'stories', ['user_id'])
    op.create_index('ix_stories_expires_at', 'stories', ['expires_at'])

    # Create story_views table
    op.create_table(
        'story_views',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('story_id', sa.Integer(), nullable=False),
        sa.Column('viewer_id', sa.Integer(), nullable=False),
        sa.Column('viewed_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(['story_id'], ['stories.id'], ),
        sa.ForeignKeyConstraint(['viewer_id'], ['users.id'], ),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index('ix_story_views_story_id', 'story_views', ['story_id'])
    op.create_index('ix_story_views_viewer_id', 'story_views', ['viewer_id'])

    # Add GiST index for location search optimization
    op.execute('CREATE INDEX IF NOT EXISTS idx_user_profiles_location ON user_profiles USING GIST (location);')
    
    # Add indexes for matching optimization
    op.create_index('ix_likes_from_to_users', 'likes', ['from_user_id', 'to_user_id'])
    op.create_index('ix_matches_users', 'matches', ['user1_id', 'user2_id'])
    
    # Add partial index for active users
    op.execute(
        'CREATE INDEX IF NOT EXISTS ix_users_active ON users (id) WHERE is_active = true;'
    )
    
    # Add index for user score sorting
    op.execute('CREATE INDEX IF NOT EXISTS ix_user_scores_score ON user_scores (score DESC);')

    # Partition messages table by month
    op.execute("""
        CREATE TABLE messages_new (
            id INTEGER,
            match_id INTEGER,
            sender_id INTEGER,
            content TEXT NOT NULL,
            content_type VARCHAR DEFAULT 'text',
            is_read BOOLEAN DEFAULT FALSE,
            created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
            PRIMARY KEY (id, created_at)
        ) PARTITION BY RANGE (created_at);
    """)
    
    # Create partitions for the last 3 months and future month
    for i in range(-2, 2):
        suffix = "past" if i < 0 else "future" if i > 0 else "current"
        op.execute(f"""
            CREATE TABLE messages_{suffix}_{abs(i)} 
            PARTITION OF messages_new 
            FOR VALUES FROM 
                (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '{i} month') 
            TO 
                (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '{i+1} month');
        """)


def downgrade():
    # Drop story related tables
    op.drop_table('story_views')
    op.drop_table('stories')
    
    # Drop indexes
    op.execute('DROP INDEX IF EXISTS idx_user_profiles_location;')
    op.drop_index('ix_likes_from_to_users')
    op.drop_index('ix_matches_users')
    op.execute('DROP INDEX IF EXISTS ix_users_active;')
    op.execute('DROP INDEX IF EXISTS ix_user_scores_score;')
    
    # Drop partitioned messages table
    op.execute('DROP TABLE IF EXISTS messages_new CASCADE;')
