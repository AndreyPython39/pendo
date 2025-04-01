"""add story reactions

Revision ID: add_story_reactions
Revises: v1_initial_schema
Create Date: 2025-03-30 18:32:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision: str = 'add_story_reactions'
down_revision: Union[str, None] = 'v1_initial_schema'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('story_reactions',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('story_id', sa.Integer(), nullable=False),
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.Column('reaction_type', sa.String(), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default='now()', nullable=False),
        sa.ForeignKeyConstraint(['story_id'], ['stories.id'], ),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
        sa.PrimaryKeyConstraint('id'),
        sa.CheckConstraint("reaction_type IN ('like', 'love', 'haha', 'wow', 'sad', 'angry')",
                          name='valid_story_reaction_type')
    )
    op.create_index('ix_story_reactions_story_id', 'story_reactions', ['story_id'])
    op.create_index('ix_story_reactions_user_id', 'story_reactions', ['user_id'])
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index('ix_story_reactions_user_id', table_name='story_reactions')
    op.drop_index('ix_story_reactions_story_id', table_name='story_reactions')
    op.drop_table('story_reactions')
    # ### end Alembic commands ###
