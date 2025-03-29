# Pendo Mobile App

A modern dating app built with Flutter that focuses on meaningful connections through shared interests and activities.

## Features

### 1. Authentication
- Phone number verification
- Social media login
- Profile creation and editing
- Location-based services
- Privacy settings

### 2. Matching
- Profile cards with photos and basic info
- Swipe gestures for like/pass
- Super Like and Boost features
- Match notifications
- Advanced filters and preferences
- AI-powered recommendations

### 3. Chat
- Real-time messaging
- Image and video sharing
- Voice messages
- Typing indicators
- Read receipts
- Message reactions
- Quick replies
- Message translation

### 4. Stories
- Photo and video stories
- Story reactions
- Story replies
- Story highlights
- View tracking
- Privacy controls

### 5. Tribes
- Interest-based groups
- Event organization
- Group discussions
- Voting system
- Member management
- Activity feed
- Tribe analytics
- Event calendar

### 6. Premium Features
- See who liked you
- Advanced filters
- Unlimited likes
- Profile boost
- Super likes
- Rewind last swipe
- Passport (change location)
- Ad-free experience

## Architecture

The app follows Clean Architecture principles with three main layers:

1. Presentation Layer (UI)
   - BLoC pattern for state management
   - Responsive design
   - Material Design 3
   - Custom animations
   - Accessibility support

2. Domain Layer (Business Logic)
   - Use cases
   - Repositories interfaces
   - Domain models
   - Business rules
   - Validation logic

3. Data Layer (Data Access)
   - API clients
   - Local storage
   - Data models
   - Data sources
   - Caching strategy

4. Core Infrastructure
   - Dependency injection
   - Navigation
   - Logging
   - Error handling
   - Analytics

## Tech Stack

- Flutter SDK
- Dart
- flutter_bloc for state management
- get_it for dependency injection
- dio for HTTP client
- hive for local storage
- web_socket_channel for WebSocket
- cached_network_image for image caching
- intl for internationalization
- timeago for relative time
- image_picker for media selection

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio / VS Code
- Git

### Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/pendo-mobile.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── config/
│   ├── navigation/
│   ├── theme/
│   └── utils/
├── features/
│   ├── auth/
│   ├── matching/
│   ├── chat/
│   └── tribes/
└── main.dart
```

## Documentation

- [Architecture Overview](Project_documentation/architecture.md)
- [UI Components](Project_documentation/ui_components.md)
- [State Management](Project_documentation/state_management.md)
- [API Integration](Project_documentation/api_integration.md)
- [Security](Project_documentation/security.md)
- [Testing](Project_documentation/testing.md)
- [Logging](Project_documentation/logging.md)
- [Mobile Features](Project_documentation/mobile_features.md)

## Development

### Setup
1. Install prerequisites
   - Flutter SDK
   - Android Studio / VS Code
   - Git
   - Firebase CLI

2. Environment setup
   ```bash
   # Clone repository
   git clone https://github.com/yourusername/pendo.git
   cd pendo

   # Install dependencies
   flutter pub get

   # Setup Firebase
   flutterfire configure

   # Generate code
   flutter pub run build_runner build
   ```

### Running
```bash
# Development
flutter run --flavor development

# Staging
flutter run --flavor staging

# Production
flutter run --flavor production
```

### Testing
```bash
# Unit tests
flutter test

# Integration tests
flutter drive --target=test_driver/app.dart

# Coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
