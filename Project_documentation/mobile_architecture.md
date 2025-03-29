# Pendo Mobile Architecture

## 1. Архитектурные принципы

### Clean Architecture
```
Presentation Layer (UI)
↓
Domain Layer (Business Logic)
↓
Data Layer (Repository & Data Sources)
```

### SOLID Principles
- Single Responsibility
- Open/Closed
- Liskov Substitution
- Interface Segregation
- Dependency Inversion

### State Management
- BLoC Pattern (Business Logic Component)
- Единый поток данных
- Предсказуемое управление состоянием

## 2. Структура проекта

### Core Layer
```dart
lib/core/
├── config/
│   ├── app_config.dart       // Конфигурация приложения
│   ├── env_config.dart       // Переменные окружения
│   └── theme_config.dart     // Темы приложения
├── constants/
│   ├── api_constants.dart    // API эндпоинты
│   ├── app_constants.dart    // Константы приложения
│   └── assets_constants.dart // Пути к ресурсам
├── navigation/
│   ├── app_router.dart      // Навигация
│   └── route_names.dart     // Имена маршрутов
└── utils/
    ├── api_client.dart      // HTTP клиент
    ├── validators.dart      // Валидация
    └── extensions.dart      // Расширения
```

### Features Layer
```dart
lib/features/
├── auth/
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   └── auth_response_model.dart
│   │   ├── repositories/
│   │   │   └── auth_repository_impl.dart
│   │   └── datasources/
│   │       ├── auth_remote_data_source.dart
│   │       └── auth_local_data_source.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── user_entity.dart
│   │   ├── repositories/
│   │   │   └── auth_repository.dart
│   │   └── usecases/
│   │       ├── login_usecase.dart
│   │       └── register_usecase.dart
│   └── presentation/
│       ├── bloc/
│       │   ├── auth_bloc.dart
│       │   ├── auth_event.dart
│       │   └── auth_state.dart
│       ├── pages/
│       │   ├── login_page.dart
│       │   └── register_page.dart
│       └── widgets/
│           ├── auth_form.dart
│           └── social_auth_buttons.dart
```

### Shared Layer
```dart
lib/shared/
├── widgets/
│   ├── buttons/
│   │   ├── primary_button.dart
│   │   └── social_button.dart
│   ├── cards/
│   │   ├── profile_card.dart
│   │   └── tribe_card.dart
│   └── dialogs/
│       ├── loading_dialog.dart
│       └── error_dialog.dart
└── services/
    ├── analytics_service.dart
    ├── storage_service.dart
    └── notification_service.dart
```

## 3. Основные компоненты

### Authentication
- JWT токены
- Биометрическая аутентификация
- Социальная аутентификация
- Верификация телефона/email

### Profile Management
- Загрузка фото
- Геолокация
- Настройки приватности
- Премиум функции

### Matching System
- Свайп механика
- Алгоритм матчинга
- Фильтры поиска
- Буст профиля

### Chat System
- Реалтайм сообщения
- Медиа сообщения
- Push уведомления
- Статусы сообщений

### Tribes
- Создание/управление
- Групповые чаты
- Голосования
- Мероприятия

## 4. Технические детали

### API Integration
```dart
// API Client
class ApiClient {
  final Dio dio;
  final String baseUrl;
  
  Future<Response> get(String path) async {
    try {
      return await dio.get('$baseUrl$path');
    } catch (e) {
      throw handleError(e);
    }
  }
}

// Repository
class AuthRepository {
  final ApiClient client;
  
  Future<User> login(String email, String password) async {
    final response = await client.post('/auth/login', {
      'email': email,
      'password': password,
    });
    return User.fromJson(response.data);
  }
}
```

### State Management
```dart
// Events
abstract class AuthEvent {}
class LoginPressed extends AuthEvent {
  final String email;
  final String password;
}

// States
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginPressed>(_onLoginPressed);
  }
  
  Future<void> _onLoginPressed(
    LoginPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await repository.login(event.email, event.password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
```

### Navigation
```dart
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthBloc(
              getIt<AuthRepository>(),
            ),
            child: const LoginPage(),
          ),
        );
    }
  }
}
```

## 5. Безопасность

### Хранение данных
- Secure Storage для токенов
- Шифрование локальных данных
- Очистка кэша при выходе

### API безопасность
- HTTPS
- JWT токены
- Certificate Pinning
- Request Signing

### Приватность
- Геолокация только при использовании
- Опциональные разрешения
- Контроль видимости профиля

## 6. Performance

### Оптимизации
- Кэширование изображений
- Lazy loading списков
- Фоновая синхронизация
- Оффлайн режим

### Мониторинг
- Firebase Performance
- Crashlytics
- Analytics
- Network monitoring

## 7. Testing

### Unit Tests
```dart
void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      authBloc = AuthBloc(mockRepository);
    });

    test('emits [AuthLoading, AuthSuccess] when login is successful', () {
      when(mockRepository.login(any, any))
          .thenAnswer((_) async => User());

      expectLater(
        authBloc.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<AuthSuccess>(),
        ]),
      );

      authBloc.add(LoginPressed('email', 'password'));
    });
  });
}
```

### Widget Tests
```dart
void main() {
  testWidgets('LoginPage shows error on invalid input',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Email is required'), findsOneWidget);
  });
}
```

### Integration Tests
```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Complete login flow', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.enterText(
      find.byType(EmailField),
      'test@example.com',
    );
    await tester.enterText(
      find.byType(PasswordField),
      'password',
    );
    await tester.tap(find.byType(LoginButton));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
```

## 8. CI/CD

### GitHub Actions
```yaml
name: Flutter CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.x'
    - run: flutter pub get
    - run: flutter test
    - run: flutter build apk
```

### Fastlane
```ruby
default_platform(:android)

platform :android do
  desc "Deploy to Play Store Beta"
  lane :beta do
    gradle(
      task: "clean assembleRelease"
    )
    upload_to_play_store(
      track: 'beta',
      aab: '../build/app/outputs/bundle/release/app-release.aab'
    )
  end
end
```

## 9. Масштабирование

### Модульность
- Независимые фичи
- Переиспользуемые компоненты
- Инверсия зависимостей

### Локализация
- Мультиязычность
- Форматирование
- RTL поддержка

### Темизация
- Светлая/темная тема
- Кастомные цвета
- Динамические шрифты
