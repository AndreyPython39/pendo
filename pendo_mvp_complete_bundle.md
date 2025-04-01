# 📱 Pendo — Полное описание проекта (MVP, март 2025)

## 🎯 Концепт

Pendo — это гибрид дейтинг-приложения и социальной платформы, построенной вокруг:
- Tribes — сообщества по интересам
- Stories — анонимные 24ч публикации
- Pendo Score — геймификация взаимодействий
- Pendo Shout — краткое самовыражение 1 раз в день
- Match + Chat — классическое дейтинг-ядро

---

## 📲 Основные экраны (Табы)

### 1. Discover
- Свайп-карточки профилей
- Icebreaker-подсказки
- Pendo Shout — живая лента
- Stories — анонимные истории
- Фильтры (гео, Tribe)

### 2. Tribes
- Список Tribe'ов
- Вступление / создание
- Голосование за лидеров
- Рейтинг активности
- Челленджи

### 3. Chat
- Список чатов
- Переписка (текст, emoji, стикеры)
- Подарки
- Жалоба / блокировка

### 4. Profile
- Инфо пользователя
- Pendo Score
- Подарки
- Редактировать профиль
- Выйти

### 5. Settings / More
- Язык
- FAQ / Поддержка
- Premium
- Безопасность

---

## 📢 Pendo Shout
- Публикация 1 раз в день
- Фото/видео (необязательно)
- Текст до 20 символов
- Привязка к Tribe
- Реакции (🔥, ❤️, 👀)
- +5 к Pendo Score

---

## 📸 Stories
- Анонимные публикации
- Псевдонимы (User123)
- Реакции
- AI-модерация

---

## 🎮 Pendo Score
- +10 чат
- +20 подарок
- +30 Tribe
- +5 Shout / Story
- Ачивки: “Мастер общения”, “Король Tribes”, “Shout Star”

---

## 🔐 Авторизация
- Email + код
- Telegram fallback
- Профиль: имя, пол, возраст, интересы, Tribe
- В будущем: Discord / Google / Apple

---

## 🎁 Gifts & Premium
- Витрина подарков
- Premium:
  - Приоритет в ленте
  - Видеть лайки
  - Эксклюзивные подарки

---

## 👮 Модерация
- AI-фильтрация
- Жалобы
- Блокировки

---

## ⚙️ Техническая архитектура
- Flutter (клиент)
- FastAPI + PostgreSQL (бэкенд)
- Redis + WebSocket (чат)
- PostGIS (геолокация)

---

## API Endpoints (основные)

### AUTH
- POST /auth/request-code
- POST /auth/verify-code

### PROFILE
- GET /profile/me
- PUT /profile/update
- POST /profile/upload-photo

### DISCOVER
- GET /discover/users
- POST /discover/swipe

### MATCHES & CHAT
- GET /chat/matches
- GET /chat/{match_id}/messages
- POST /chat/{match_id}/send

### TRIBES
- GET /tribes
- POST /tribes/join
- POST /tribes/create
- POST /tribes/vote

### STORIES
- GET /stories
- POST /stories/upload

### SHOUTS
- GET /shouts
- POST /shouts/create

---

## Flutter UI Components (названия и состояния)

- OnboardingScreen
- AuthScreen (EmailInput, CodeInput)
- CreateProfileScreen
- DiscoverScreen (SwipeCard, ShoutList, StoryBar)
- TribeScreen (TribeList, TribeCard, VoteDialog)
- ChatListScreen
- ChatScreen (MessageBubble, GiftButton)
- ProfileScreen (ScoreBar, GiftList)
- SettingsScreen

---

## 🧪 Test Cases (основные)

- Успешная регистрация нового пользователя
- Публикация Shout (1 раз в день)
- Отправка сообщения в чате
- Вступление в Tribe
- Голосование за лидера Tribe
- Публикация Story (с AI-модерацией)
- Получение подарка
- Жалоба на пользователя

---

## 🏁 MVP включает:

- [x] Авторизация по email
- [x] Профиль и Tribe
- [x] Discover + свайп + чат
- [x] Pendo Score
- [x] Gifts
- [x] Shout
- [ ] Stories (если успеем)

---

## 🚀 Дорожная карта (по спринтам)

| Спринт | Что делаем |
|--------|------------|
| S1     | Авторизация + Профиль |
| S2     | Discover + Match + Chat |
| S3     | Tribes + Shout |
| S4     | Stories + Score |
| S5     | Gifts + Premium |
| S6     | Polish + Тестирование

# 🧾 TODO для разработки MVP

# ✅ TODO для разработки Pendo MVP (по спринтам)

## 📦 Спринт 1: Авторизация и профиль
- [ ] Реализовать API: /auth/request-code
- [ ] Реализовать API: /auth/verify-code
- [ ] Экран EmailInput → CodeInput → Создание профиля
- [ ] Хранение токена и проверка на старте приложения

## 💘 Спринт 2: Discover + Match + Chat
- [ ] API: /discover/users
- [ ] Свайп-карточки
- [ ] API: /chat/matches, /chat/{match_id}/messages
- [ ] Чат с WebSocket
- [ ] Icebreaker генератор (заглушка)

## 🌐 Спринт 3: Tribes + Shout
- [ ] API: /tribes, /tribes/join, /tribes/vote
- [ ] Экран Tribe List + вступление
- [ ] Экран голосования
- [ ] API: /shouts, /shouts/create
- [ ] Компонент Shout (публикация и просмотр)

## 🎭 Спринт 4: Stories + Score
- [ ] API: /stories, /stories/upload
- [ ] Компонент StoryBar
- [ ] Просмотр и создание историй
- [ ] Pendo Score (логика подсчета, прогрессбар)

## 🎁 Спринт 5: Gifts + Premium
- [ ] API: витрина подарков, отправка
- [ ] Экран Premium: преимущества
- [ ] Интеграция с чатом

## 🧼 Спринт 6: Polish + Final Test
- [ ] Настройки (язык, профиль, выход)
- [ ] Модерация: жалобы, блокировки
- [ ] Тестирование кейсов
- [ ] Сборка и публикация в Google Play

# 📊 OpenAPI спецификация (MVP)

```json
{
  "openapi": "3.0.0",
  "info": {
    "title": "Pendo API",
    "version": "1.0.0",
    "description": "OpenAPI \u0441\u043f\u0435\u0446\u0438\u0444\u0438\u043a\u0430\u0446\u0438\u044f \u0434\u043b\u044f MVP \u043f\u0440\u043e\u0435\u043a\u0442\u0430 Pendo"
  },
  "paths": {
    "/auth/request-code": {
      "post": {
        "summary": "\u0417\u0430\u043f\u0440\u043e\u0441 \u043a\u043e\u0434\u0430 \u0430\u0432\u0442\u043e\u0440\u0438\u0437\u0430\u0446\u0438\u0438",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "type": "object",
                "properties": {
                  "email": {
                    "type": "string"
                  }
                },
                "required": [
                  "email"
                ]
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "\u041a\u043e\u0434 \u043e\u0442\u043f\u0440\u0430\u0432\u043b\u0435\u043d"
          }
        }
      }
    },
    "/auth/verify-code": {
      "post": {
        "summary": "\u041f\u0440\u043e\u0432\u0435\u0440\u043a\u0430 \u043a\u043e\u0434\u0430",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "type": "object",
                "properties": {
                  "email": {
                    "type": "string"
                  },
                  "code": {
                    "type": "string"
                  }
                },
                "required": [
                  "email",
                  "code"
                ]
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "\u0423\u0441\u043f\u0435\u0448\u043d\u0430\u044f \u0430\u0432\u0442\u043e\u0440\u0438\u0437\u0430\u0446\u0438\u044f"
          }
        }
      }
    },
    "/profile/me": {
      "get": {
        "summary": "\u041f\u043e\u043b\u0443\u0447\u0435\u043d\u0438\u0435 \u0442\u0435\u043a\u0443\u0449\u0435\u0433\u043e \u043f\u0440\u043e\u0444\u0438\u043b\u044f",
        "responses": {
          "200": {
            "description": "\u0414\u0430\u043d\u043d\u044b\u0435 \u043f\u0440\u043e\u0444\u0438\u043b\u044f"
          }
        }
      }
    },
    "/discover/users": {
      "get": {
        "summary": "\u041f\u043e\u043b\u0443\u0447\u0435\u043d\u0438\u0435 \u0441\u043f\u0438\u0441\u043a\u0430 \u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u0435\u0439 \u0434\u043b\u044f Discover",
        "responses": {
          "200": {
            "description": "\u0421\u043f\u0438\u0441\u043e\u043a \u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u0435\u0439"
          }
        }
      }
    },
    "/shouts/create": {
      "post": {
        "summary": "\u0421\u043e\u0437\u0434\u0430\u043d\u0438\u0435 Pendo Shout",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "type": "object",
                "properties": {
                  "text": {
                    "type": "string",
                    "maxLength": 20
                  },
                  "media_url": {
                    "type": "string"
                  },
                  "tribe_id": {
                    "type": "integer"
                  }
                },
                "required": [
                  "text"
                ]
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Shout \u0441\u043e\u0437\u0434\u0430\u043d"
          }
        }
      }
    }
  }
}
```