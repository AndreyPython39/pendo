"""combined updates

Revision ID: f6g7h8i9j0k1
Revises: 80d5f891d3e6
Create Date: 2025-03-30 16:52:00.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic
revision = 'f6g7h8i9j0k1'
down_revision = '80d5f891d3e6'
branch_labels = None
depends_on = None

def upgrade():
    # 1. Создаем enum тип для swipe action
    op.execute("""
    DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'swipe_action') THEN
            CREATE TYPE swipe_action AS ENUM ('like', 'dislike');
        END IF;
    END$$;
    """)
    
    # 2. Создаем таблицу tribe_members если её нет
    op.execute("""
    CREATE TABLE IF NOT EXISTS tribe_members (
        tribe_id INTEGER REFERENCES tribes(id) ON DELETE CASCADE,
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        joined_at TIMESTAMP NOT NULL DEFAULT NOW(),
        PRIMARY KEY (tribe_id, user_id)
    );
    CREATE INDEX IF NOT EXISTS idx_tribe_members_tribe_id ON tribe_members(tribe_id);
    CREATE INDEX IF NOT EXISTS idx_tribe_members_user_id ON tribe_members(user_id);
    """)
    
    # 3. Создаем таблицу user_interests если её нет
    op.execute("""
    CREATE TABLE IF NOT EXISTS user_interests (
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        interest_id INTEGER REFERENCES interests(id) ON DELETE CASCADE,
        created_at TIMESTAMP NOT NULL DEFAULT NOW(),
        PRIMARY KEY (user_id, interest_id)
    );
    CREATE INDEX IF NOT EXISTS idx_user_interests_user_id ON user_interests(user_id);
    CREATE INDEX IF NOT EXISTS idx_user_interests_interest_id ON user_interests(interest_id);
    """)
    
    # 4. Обновляем тип колонки action в таблице swipes если она существует
    op.execute("""
    DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'swipes' AND column_name = 'action') THEN
            -- Создаем временную колонку
            ALTER TABLE swipes ADD COLUMN action_new swipe_action;
            
            -- Обновляем данные
            UPDATE swipes SET action_new = CASE 
                WHEN action = 'pass' THEN 'dislike'::swipe_action 
                ELSE action::swipe_action 
            END;
            
            -- Удаляем старую колонку и переименовываем новую
            ALTER TABLE swipes DROP COLUMN action;
            ALTER TABLE swipes RENAME COLUMN action_new TO action;
        END IF;
    END$$;
    """)

def downgrade():
    # Удаляем индексы
    op.execute("DROP INDEX IF EXISTS idx_user_interests_interest_id")
    op.execute("DROP INDEX IF EXISTS idx_user_interests_user_id")
    op.execute("DROP INDEX IF EXISTS idx_tribe_members_user_id")
    op.execute("DROP INDEX IF EXISTS idx_tribe_members_tribe_id")
    
    # Удаляем таблицы
    op.execute("DROP TABLE IF EXISTS user_interests")
    op.execute("DROP TABLE IF EXISTS tribe_members")
    
    # Возвращаем тип VARCHAR для action в swipes
    op.execute("""
    DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'swipes' AND column_name = 'action') THEN
            -- Создаем временную колонку
            ALTER TABLE swipes ADD COLUMN action_old VARCHAR(10);
            
            -- Копируем данные
            UPDATE swipes SET action_old = action::text;
            
            -- Удаляем старую колонку и переименовываем новую
            ALTER TABLE swipes DROP COLUMN action;
            ALTER TABLE swipes RENAME COLUMN action_old TO action;
        END IF;
    END$$;
    """)
    
    # Удаляем enum тип
    op.execute("DROP TYPE IF EXISTS swipe_action")
