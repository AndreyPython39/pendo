import logging
from sqlalchemy import text
from app.db.session import engine

logger = logging.getLogger(__name__)

def init_db() -> None:
    try:
        # Читаем SQL файл
        with open("app/db/init_db.sql") as f:
            sql_commands = f.read()
        
        # Выполняем SQL команды
        with engine.connect() as connection:
            connection.execute(text(sql_commands))
            connection.commit()
            
        logger.info("База данных инициализирована успешно")
    except Exception as e:
        logger.error(f"Ошибка при инициализации базы данных: {e}")
        raise
