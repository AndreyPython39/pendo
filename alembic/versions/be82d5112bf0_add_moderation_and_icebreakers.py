"""add_moderation_and_icebreakers

Revision ID: be82d5112bf0
Revises: 30c0486c441e
Create Date: 2025-03-29 21:32:32.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = 'be82d5112bf0'
down_revision: Union[str, None] = '30c0486c441e'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # Create enum for moderation action types
    op.execute("CREATE TYPE moderationaction AS ENUM ('approve', 'reject', 'block', 'unblock', 'warn')")
    
    # Create enum for object types that can be moderated
    op.execute("CREATE TYPE moderationobject AS ENUM ('user', 'profile', 'tribe', 'message', 'photo')")

    # Create moderation_logs table
    op.create_table('moderation_logs',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('moderator_id', sa.Integer(), nullable=False),
        sa.Column('object_type', postgresql.ENUM('user', 'profile', 'tribe', 'message', 'photo', name='moderationobject', create_type=False), nullable=False),
        sa.Column('object_id', sa.Integer(), nullable=False),
        sa.Column('action', postgresql.ENUM('approve', 'reject', 'block', 'unblock', 'warn', name='moderationaction', create_type=False), nullable=False),
        sa.Column('reason', sa.String(), nullable=True),
        sa.Column('extra_data', postgresql.JSONB(), nullable=True),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(['moderator_id'], ['users.id'], ),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_moderation_logs_object_id'), 'moderation_logs', ['object_id'], unique=False)
    op.create_index(op.f('ix_moderation_logs_object_type'), 'moderation_logs', ['object_type'], unique=False)

    # Create icebreaker_questions table
    op.create_table('icebreaker_questions',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('question', sa.String(), nullable=False),
        sa.Column('category', sa.String(), nullable=True),
        sa.Column('language', sa.String(), nullable=False),
        sa.Column('is_active', sa.Boolean(), nullable=False, server_default=sa.text('true')),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_icebreaker_questions_language'), 'icebreaker_questions', ['language'], unique=False)

    # Create icebreaker_answers table
    op.create_table('icebreaker_answers',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('match_id', sa.Integer(), nullable=False),
        sa.Column('question_id', sa.Integer(), nullable=False),
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.Column('answer', sa.String(), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(['match_id'], ['matches.id'], ),
        sa.ForeignKeyConstraint(['question_id'], ['icebreaker_questions.id'], ),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
        sa.PrimaryKeyConstraint('id')
    )

    # Create photos table
    op.create_table('photos',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.Column('url', sa.String(), nullable=False),
        sa.Column('is_primary', sa.Boolean(), nullable=False, server_default=sa.text('false')),
        sa.Column('moderation_status', sa.String(), nullable=False, server_default=sa.text("'pending'")),
        sa.Column('moderated_by', sa.Integer(), nullable=True),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(['moderated_by'], ['users.id'], ),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
        sa.PrimaryKeyConstraint('id')
    )

    # Add last_tribe_created_at to users table
    op.add_column('users', sa.Column('last_tribe_created_at', sa.DateTime(timezone=True), nullable=True))

    # Create functions and triggers for tribe creation limit
    op.execute("""
    CREATE OR REPLACE FUNCTION check_tribe_creation_limit()
    RETURNS TRIGGER AS $$
    BEGIN
        IF EXISTS (
            SELECT 1 FROM users 
            WHERE id = NEW.creator_id 
            AND last_tribe_created_at IS NOT NULL 
            AND last_tribe_created_at > NOW() - INTERVAL '30 days'
        ) THEN
            RAISE EXCEPTION 'Users can only create one tribe every 30 days';
        END IF;
        
        UPDATE users 
        SET last_tribe_created_at = NOW() 
        WHERE id = NEW.creator_id;
        
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    """)

    op.execute("""
    CREATE TRIGGER tribe_creation_limit
    BEFORE INSERT ON tribes
    FOR EACH ROW
    EXECUTE FUNCTION check_tribe_creation_limit();
    """)

    # Create function to update updated_at timestamp
    op.execute("""
    CREATE OR REPLACE FUNCTION update_updated_at_column()
    RETURNS TRIGGER AS $$
    BEGIN
        NEW.updated_at = NOW();
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    """)

    # Add updated_at triggers to all relevant tables
    for table in ['users', 'user_profiles', 'tribes', 'photos', 'icebreaker_questions']:
        op.execute(f"""
        CREATE TRIGGER update_timestamp
        BEFORE UPDATE ON {table}
        FOR EACH ROW
        EXECUTE FUNCTION update_updated_at_column();
        """)


def downgrade() -> None:
    # Drop triggers first
    for table in ['users', 'user_profiles', 'tribes', 'photos', 'icebreaker_questions']:
        op.execute(f"DROP TRIGGER IF EXISTS update_timestamp ON {table}")

    # Drop functions
    op.execute("DROP FUNCTION IF EXISTS update_updated_at_column()")
    op.execute("DROP FUNCTION IF EXISTS check_tribe_creation_limit()")

    # Drop tribe creation trigger
    op.execute("DROP TRIGGER IF EXISTS tribe_creation_limit ON tribes")

    # Drop tables
    op.drop_table('icebreaker_answers')
    op.drop_table('icebreaker_questions')
    op.drop_table('moderation_logs')
    op.drop_table('photos')

    # Drop columns
    op.drop_column('users', 'last_tribe_created_at')

    # Drop enums
    op.execute("DROP TYPE moderationaction")
    op.execute("DROP TYPE moderationobject")
