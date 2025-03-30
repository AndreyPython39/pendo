"""update models

Revision ID: h8i9j0k1l2m3
Revises: g7h8i9j0k1l2
Create Date: 2025-03-30 17:02:00.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'h8i9j0k1l2m3'
down_revision = 'g7h8i9j0k1l2'
branch_labels = None
depends_on = None

def upgrade():
    # 1. Добавляем недостающие поля в таблицу users
    op.execute("""
    ALTER TABLE users 
    ADD COLUMN IF NOT EXISTS name VARCHAR(255),
    ADD COLUMN IF NOT EXISTS birthdate DATE,
    ADD COLUMN IF NOT EXISTS gender VARCHAR(10),
    ADD COLUMN IF NOT EXISTS pendo_score INTEGER DEFAULT 0;
    """)
    
    # 2. Создаем enum тип для gift_type
    op.execute("""
    DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'gift_type') THEN
            CREATE TYPE gift_type AS ENUM ('flower', 'heart', 'star', 'diamond');
        END IF;
    END$$;
    """)
    
    # 3. Обновляем тип колонки gift_type в таблице gifts
    op.execute("""
    DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'gifts' AND column_name = 'gift_type') THEN
            -- Создаем временную колонку
            ALTER TABLE gifts ADD COLUMN gift_type_new gift_type;
            
            -- Обновляем данные
            UPDATE gifts SET gift_type_new = gift_type::gift_type;
            
            -- Удаляем старую колонку и переименовываем новую
            ALTER TABLE gifts DROP COLUMN gift_type;
            ALTER TABLE gifts RENAME COLUMN gift_type_new TO gift_type;
        END IF;
    END$$;
    """)
    
    # 4. Добавляем ограничение для gender
    op.execute("""
    ALTER TABLE users 
    ADD CONSTRAINT check_gender CHECK (gender IN ('male', 'female', 'other'));
    """)
    
    # 5. Добавляем ограничение для pendo_score
    op.execute("""
    ALTER TABLE users 
    ADD CONSTRAINT check_pendo_score CHECK (pendo_score >= 0 AND pendo_score <= 100);
    """)

def downgrade():
    # 1. Удаляем ограничения
    op.execute("""
    ALTER TABLE users 
    DROP CONSTRAINT IF EXISTS check_gender,
    DROP CONSTRAINT IF EXISTS check_pendo_score;
    """)
    
    # 2. Удаляем колонки из таблицы users
    op.execute("""
    ALTER TABLE users 
    DROP COLUMN IF EXISTS name,
    DROP COLUMN IF EXISTS birthdate,
    DROP COLUMN IF EXISTS gender,
    DROP COLUMN IF EXISTS pendo_score;
    """)
    
    # 3. Возвращаем тип VARCHAR для gift_type
    op.execute("""
    DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'gifts' AND column_name = 'gift_type') THEN
            -- Создаем временную колонку
            ALTER TABLE gifts ADD COLUMN gift_type_old VARCHAR(50);
            
            -- Копируем данные
            UPDATE gifts SET gift_type_old = gift_type::text;
            
            -- Удаляем старую колонку и переименовываем новую
            ALTER TABLE gifts DROP COLUMN gift_type;
            ALTER TABLE gifts RENAME COLUMN gift_type_old TO gift_type;
        END IF;
    END$$;
    """)
    
    # 4. Удаляем enum тип
    op.execute("DROP TYPE IF EXISTS gift_type")
