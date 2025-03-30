# 📊 Сводная реализация объектов Pendo

| Объект         | Фронт (модель)                       | Бэк (модель)                             | БД (таблица) | API реализован        | Проблемы |
|----------------|--------------------------------------|------------------------------------------|--------------|------------------------|----------|
| User | ✅ UserModel | ✅ User, UserCreate, UserResponse | ✅ users | ✅ | Отсутствуют некоторые поля во фронте (`is_active`, `pendo_score`, `avatar_url`) |
| Gift | ✅ gift_model.dart | ✅ VirtualGift, GiftTransaction, GiftCollection | ✅ gifts | ✅ | camelCase ↔ snake_case в моделях |
| Swipe | ❌ | ✅ Swipe | ✅ swipes | ✅ | Нет фронт-модели |
| Match | ✅ match_model.dart | ✅ Match | ✅ matches | ✅ | - |
| Chat / Message | ✅ chat_model.dart, message_model.dart | ✅ Chat, Message | ✅ messages | ✅ | - |
| Story | ✅ story_model.dart | ✅ Story | ✅ stories | ✅ | Требуется улучшение интеграции с фронтом |
| Tribe | ✅ tribe_model.dart | ✅ Tribe | ✅ tribes | ✅ | Требуется улучшение UX на фронте |
| Icebreaker | ❌ | ✅ IcebreakerQuestion, IcebreakerAnswer | ✅ icebreakers | ✅ | Нет поддержки на фронте |
| Pendo Score | ❌ | ✅ (в User и UserScore) | ✅ (поле в users и user_scores) | ✅ | Нет отображения на фронте |
| Moderation | ✅ moderation_model.dart | ✅ ModerationLog | ✅ moderation_logs | ✅ | Требуется улучшение UI для модераторов |
