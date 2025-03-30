"""fix all inconsistencies

Revision ID: i9j0k1l2m3n4
Revises: h8i9j0k1l2m3
Create Date: 2025-03-30 17:03:00.000000

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic
revision = 'i9j0k1l2m3n4'
down_revision = 'h8i9j0k1l2m3'
branch_labels = None
depends_on = None

def upgrade():
    # 1. Обновляем таблицу users
    op.execute("""
    -- Добавляем недостающие поля
    ALTER TABLE users 
    ADD COLUMN IF NOT EXISTS name VARCHAR(255),
    ADD COLUMN IF NOT EXISTS birthdate DATE,
    ADD COLUMN IF NOT EXISTS gender VARCHAR(10),
    ADD COLUMN IF NOT EXISTS pendo_score INTEGER DEFAULT 0,
    ADD COLUMN IF NOT EXISTS avatar_url TEXT,
    ADD COLUMN IF NOT EXISTS bio TEXT,
    ADD COLUMN IF NOT EXISTS location_lat DECIMAL(9,6),
    ADD COLUMN IF NOT EXISTS location_lon DECIMAL(9,6);

    -- Обновляем существующие колонки
    ALTER TABLE users 
    ALTER COLUMN hashed_password TYPE VARCHAR(255),
    ALTER COLUMN email TYPE VARCHAR(255);

    -- Добавляем ограничения, если их нет
    DO $$
    BEGIN
        IF NOT EXISTS (
            SELECT 1 FROM information_schema.constraint_column_usage 
            WHERE constraint_name = 'check_gender'
        ) THEN
            ALTER TABLE users 
            ADD CONSTRAINT check_gender CHECK (gender IN ('male', 'female', 'other'));
        END IF;

        IF NOT EXISTS (
            SELECT 1 FROM information_schema.constraint_column_usage 
            WHERE constraint_name = 'check_pendo_score'
        ) THEN
            ALTER TABLE users 
            ADD CONSTRAINT check_pendo_score CHECK (pendo_score >= 0 AND pendo_score <= 100);
        END IF;

        IF NOT EXISTS (
            SELECT 1 FROM information_schema.constraint_column_usage 
            WHERE constraint_name = 'check_location'
        ) THEN
            ALTER TABLE users 
            ADD CONSTRAINT check_location CHECK (
                (location_lat IS NULL AND location_lon IS NULL) OR 
                (location_lat IS NOT NULL AND location_lon IS NOT NULL)
            );
        END IF;
    END$$;

    -- Индексы для users
    CREATE INDEX IF NOT EXISTS idx_users_location ON users (location_lat, location_lon);
    CREATE INDEX IF NOT EXISTS idx_users_pendo_score ON users (pendo_score);
    CREATE INDEX IF NOT EXISTS idx_users_birthdate ON users (birthdate);
    """)

def downgrade():
    op.execute("""
    -- Удаляем индексы
    DROP INDEX IF EXISTS idx_users_location;
    DROP INDEX IF EXISTS idx_users_pendo_score;
    DROP INDEX IF EXISTS idx_users_birthdate;

    -- Удаляем ограничения
    ALTER TABLE users 
    DROP CONSTRAINT IF EXISTS check_gender,
    DROP CONSTRAINT IF EXISTS check_pendo_score,
    DROP CONSTRAINT IF EXISTS check_location;

    -- Удаляем колонки
    ALTER TABLE users 
    DROP COLUMN IF EXISTS name,
    DROP COLUMN IF EXISTS birthdate,
    DROP COLUMN IF EXISTS gender,
    DROP COLUMN IF EXISTS pendo_score,
    DROP COLUMN IF EXISTS avatar_url,
    DROP COLUMN IF EXISTS bio,
    DROP COLUMN IF EXISTS location_lat,
    DROP COLUMN IF EXISTS location_lon;
    """)
