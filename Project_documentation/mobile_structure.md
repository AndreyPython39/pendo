# 📱 Pendo Mobile App Structure

## 🗂️ Project Structure

```
lib/
├── core/
│   ├── config/
│   │   ├── app_config.dart
│   │   ├── env_config.dart
│   │   └── theme_config.dart
│   ├── constants/
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   └── assets_constants.dart
│   ├── localization/
│   │   ├── app_localizations.dart
│   │   └── supported_locales.dart
│   ├── navigation/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   └── utils/
│       ├── api_client.dart
│       ├── validators.dart
│       └── extensions.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   └── datasources/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── profile/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── matching/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── chat/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── tribes/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── shared/
    ├── widgets/
    │   ├── buttons/
    │   ├── cards/
    │   ├── dialogs/
    │   └── forms/
    ├── models/
    └── services/
        ├── analytics_service.dart
        ├── auth_service.dart
        ├── storage_service.dart
        └── notification_service.dart
```

## 📱 Features

### 🔐 Authentication
- Phone/Email registration
- OTP verification
- Social auth (Google, Apple)
- Profile creation

### 👤 Profile
- Basic info
- Photos management
- Location settings
- Preferences
- Verification

### 💝 Matching
- Card swiping
- Match notifications
- Super likes
- Filters
- Boost feature

### 💬 Chat
- Real-time messaging
- Media sharing
- Icebreakers
- Message status
- Blocking/Reporting

### 🏰 Tribes
- Create/Join tribes
- Tribe chat
- Leadership voting
- Tribe events
- Member management

## 🎨 UI Components

### Shared Widgets
- Custom buttons
- Loading indicators
- Error states
- Input fields
- Cards
- Modals

### Theme
- Colors
- Typography
- Spacing
- Animations
- Icons

## 📦 Dependencies

### State Management
- flutter_bloc
- equatable

### Network
- dio
- connectivity_plus

### Storage
- shared_preferences
- hive

### Location
- geolocator
- geocoding

### Firebase
- firebase_core
- firebase_auth
- firebase_messaging
- firebase_analytics

### UI
- google_fonts
- flutter_svg
- cached_network_image
- shimmer
- carousel_slider

### Utils
- intl
- logger
- image_picker
- url_launcher

## 🔧 Configuration

### Environment Variables
```dart
class EnvConfig {
  static const apiUrl = String.fromEnvironment('API_URL');
  static const googleMapsKey = String.fromEnvironment('GOOGLE_MAPS_KEY');
  static const sentryDsn = String.fromEnvironment('SENTRY_DSN');
}
```

### Feature Flags
```dart
class FeatureFlags {
  static const enableTribes = true;
  static const enableVideoChat = false;
  static const enablePremiumFeatures = true;
}
```

## 🔒 Security

### API Security
- JWT token management
- Secure storage
- Certificate pinning
- Request signing

### Data Protection
- Encryption at rest
- Secure file storage
- Privacy settings
- Data deletion

## 📊 Analytics

### Events to Track
- User registration
- Profile completion
- Swipe actions
- Matches
- Messages
- Tribe actions
- Premium conversions

### Metrics
- Daily active users
- Match rate
- Message response time
- Tribe engagement
- Premium conversion rate

## 🚀 Performance

### Optimization
- Image caching
- Lazy loading
- Background fetch
- Offline support
- Memory management

### Monitoring
- Crash reporting
- Performance metrics
- Network analytics
- Battery usage

## 📱 Platform Integration

### Android
- Material Design 3
- Notification channels
- Deep linking
- Google Play billing
- Firebase Cloud Messaging

### Permissions
- Location
- Camera
- Storage
- Notifications
- Contacts (optional)

## 🌍 Localization

### Supported Languages
- English (en)
- Swahili (sw)
- Zulu (zu)

### Content
- UI strings
- Error messages
- Push notifications
- Email templates

## 🧪 Testing

### Unit Tests
- Business logic
- Data models
- Utils
- Repositories

### Widget Tests
- UI components
- Screen flows
- Error states
- Loading states

### Integration Tests
- API integration
- Database operations
- Authentication flow
- Core features
