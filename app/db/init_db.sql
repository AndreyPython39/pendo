-- Создание пользователя pendo с паролем
CREATE USER pendo WITH PASSWORD 'pendopass';

-- Даем пользователю права на базу данных
ALTER DATABASE pendo OWNER TO pendo;

-- Даем все права на схему public
GRANT ALL ON SCHEMA public TO pendo;

-- Даем права на создание объектов в схеме public
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO pendo;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO pendo;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO pendo;
