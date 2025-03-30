"""move profile data

Revision ID: o5p6q7r8s9t0
Revises: n4o5p6q7r8s9
Create Date: 2025-03-30 17:22:41.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'o5p6q7r8s9t0'
down_revision = 'n4o5p6q7r8s9'
branch_labels = None
depends_on = None

def upgrade():
    # 1. Переносим данные из users в user_profiles
    op.execute("""
    UPDATE user_profiles up
    SET 
        bio = u.bio,
        location = u.location,
        birthdate = u.birthdate,
        gender = u.gender
    FROM users u
    WHERE up.user_id = u.id
    AND (
        (u.bio IS NOT NULL AND up.bio IS NULL)
        OR (u.location IS NOT NULL AND up.location IS NULL)
        OR (u.birthdate IS NOT NULL AND up.birthdate IS NULL)
        OR (u.gender IS NOT NULL AND up.gender IS NULL)
    );
    """)

    # 2. Удаляем перенесенные колонки из users
    op.execute("""
    ALTER TABLE users
    DROP COLUMN IF EXISTS bio,
    DROP COLUMN IF EXISTS location,
    DROP COLUMN IF EXISTS birthdate,
    DROP COLUMN IF EXISTS gender,
    DROP COLUMN IF EXISTS location_lat,
    DROP COLUMN IF EXISTS location_lon;
    """)

def downgrade():
    # 1. Возвращаем колонки в users
    op.execute("""
    ALTER TABLE users
    ADD COLUMN IF NOT EXISTS bio text,
    ADD COLUMN IF NOT EXISTS location USER-DEFINED,
    ADD COLUMN IF NOT EXISTS birthdate date,
    ADD COLUMN IF NOT EXISTS gender character varying,
    ADD COLUMN IF NOT EXISTS location_lat numeric,
    ADD COLUMN IF NOT EXISTS location_lon numeric;
    """)

    # 2. Переносим данные обратно из user_profiles в users
    op.execute("""
    UPDATE users u
    SET 
        bio = up.bio,
        location = up.location,
        birthdate = up.birthdate,
        gender = up.gender
    FROM user_profiles up
    WHERE u.id = up.user_id
    AND (
        (up.bio IS NOT NULL AND u.bio IS NULL)
        OR (up.location IS NOT NULL AND u.location IS NULL)
        OR (up.birthdate IS NOT NULL AND u.birthdate IS NULL)
        OR (up.gender IS NOT NULL AND u.gender IS NULL)
    );
    """)
