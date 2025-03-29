# API Endpoints Documentation

## Authentication
- `POST /api/v1/auth/register` - Регистрация нового пользователя
- `POST /api/v1/auth/login/access-token` - Получение JWT токена
- `POST /api/v1/auth/verify-email/{token}` - Подтверждение email
- `POST /api/v1/auth/password-recovery/{email}` - Восстановление пароля

## Users
- `GET /api/v1/users/me` - Получение данных текущего пользователя
- `PUT /api/v1/users/me` - Обновление профиля
- `GET /api/v1/users/{id}` - Получение данных пользователя по ID

## Matches
- `GET /api/v1/matches/` - Список матчей пользователя
- `GET /api/v1/matches/{id}` - Детали матча
- `POST /api/v1/matches/{id}/like` - Лайкнуть профиль
- `POST /api/v1/matches/{id}/pass` - Пропустить профиль

## Messages
- `GET /api/v1/messages/{match_id}` - Получение сообщений чата
- `POST /api/v1/messages/{match_id}` - Отправка сообщения
- `POST /api/v1/messages/{match_id}/read` - Пометить сообщения как прочитанные

## Tribes
- `GET /api/v1/tribes/` - Список всех триб
- `GET /api/v1/tribes/my` - Трибы текущего пользователя
- `POST /api/v1/tribes/` - Создание трибы
- `POST /api/v1/tribes/{id}/join` - Вступление в трибу
- `POST /api/v1/tribes/{id}/leave` - Выход из трибы
- `POST /api/v1/tribes/{id}/vote` - Голосование в трибе

## Stories
- `GET /api/v1/stories/` - Получение списка историй
- `POST /api/v1/stories/` - Создание истории
- `GET /api/v1/stories/{id}` - Просмотр истории
- `DELETE /api/v1/stories/{id}` - Удаление истории
- `POST /api/v1/stories/{id}/view` - Отметить историю как просмотренную

## Events
- `GET /api/v1/events/` - Список событий
- `POST /api/v1/events/` - Создание события
- `GET /api/v1/events/{id}` - Детали события
- `PUT /api/v1/events/{id}` - Обновление события
- `POST /api/v1/events/{id}/join` - Присоединиться к событию
- `POST /api/v1/events/{id}/leave` - Покинуть событие

## Gifts
- `GET /api/v1/gifts/` - Список доступных подарков
- `POST /api/v1/gifts/{gift_id}/send/{receiver_id}` - Отправка подарка
- `GET /api/v1/gifts/received` - Полученные подарки
- `GET /api/v1/gifts/sent` - Отправленные подарки

## Premium
- `POST /api/v1/premium/subscribe` - Активация премиум подписки
- `POST /api/v1/premium/unsubscribe` - Отмена премиум подписки
- `GET /api/v1/premium/features` - Список премиум функций
- `GET /api/v1/premium/status` - Статус премиум подписки

## Moderation
- `GET /api/v1/moderation/photos/pending` - Фото на модерации
- `POST /api/v1/moderation/photos/{id}/moderate` - Модерация фото
- `POST /api/v1/moderation/tribes/{id}/moderate` - Модерация трибы

## Parameters

### Common Query Parameters
- `skip` - Пагинация: сколько элементов пропустить
- `limit` - Пагинация: сколько элементов вернуть
- `order_by` - Сортировка результатов
- `filter` - Фильтрация результатов

### Authentication
Все запросы (кроме /auth/*) требуют заголовок:
```
Authorization: Bearer {access_token}
```

### Response Codes
- 200: Успешный запрос
- 201: Успешное создание
- 400: Некорректный запрос
- 401: Не авторизован
- 403: Нет прав доступа
- 404: Ресурс не найден
- 422: Ошибка валидации
- 500: Внутренняя ошибка сервера