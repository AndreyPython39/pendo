# 📊 Pendo Database Structure

_Автоматически сгенерировано из информации об ограничениях PostgreSQL._

---

## 📄 users
- **PRIMARY KEY**: `id`
- **CHECK**: множественные (например, email, роли, статус)

---

## 📄 user_profiles
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `user_id` → `users(id)`
- **FOREIGN KEY**: `moderated_by` → `users(id)`
- **UNIQUE**: `user_id`
- **CHECK**: возраст, пол, валидные значения

---

## 📄 user_scores
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `user_id` → `users(id)`
- **UNIQUE**: `user_id`
- **CHECK**: диапазон очков, уровни

---

## 📄 photos
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `user_id` → `users(id)`
- **FOREIGN KEY**: `moderated_by` → `users(id)`
- **CHECK**: тип, длина, статус, URL

---

## 📄 matches
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `user1_id` → `users(id)`
- **FOREIGN KEY**: `user2_id` → `users(id)`
- **CHECK**: (например, user1 ≠ user2)

---

## 📄 messages
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `match_id` → `matches(id)`
- **FOREIGN KEY**: `sender_id` → `users(id)`
- **CHECK**: длина текста, статус

---

## 📄 likes
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `from_user_id` → `users(id)`
- **FOREIGN KEY**: `to_user_id` → `users(id)`
- **CHECK**: запрет на self-like и повтор

---

## 📄 icebreaker_questions
- **PRIMARY KEY**: `id`
- **CHECK**: валидность текста

---

## 📄 icebreaker_answers
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `match_id` → `matches(id)`
- **FOREIGN KEY**: `question_id` → `icebreaker_questions(id)`
- **FOREIGN KEY**: `user_id` → `users(id)`
- **CHECK**: валидность текста, длина и логика

---

## 📄 moderation_logs
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `moderator_id` → `users(id)`
- **CHECK**: допустимые типы и действия

---

## 📄 tribes
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `creator_id` → `users(id)`
- **FOREIGN KEY**: `chief_id` → `users(id)`
- **FOREIGN KEY**: `moderated_by` → `users(id)`
- **CHECK**: статус, размер, активность

---

## 📄 tribe_members
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `tribe_id` → `tribes(id)`
- **FOREIGN KEY**: `user_id` → `users(id)`
- **CHECK**: уникальность, роль

---

## 📄 tribe_votes
- **PRIMARY KEY**: `id`
- **FOREIGN KEY**: `tribe_id` → `tribes(id)`
- **FOREIGN KEY**: `voter_id` → `users(id)`
- **FOREIGN KEY**: `candidate_id` → `users(id)`
- **CHECK**: не голосовать за себя и др.

---

## 📄 alembic_version
- **PRIMARY KEY**: `version_num`
- **CHECK**: служебное

---

## 📄 spatial_ref_sys
- **PRIMARY KEY**: `srid`
- **CHECK**: служебное для PostGIS