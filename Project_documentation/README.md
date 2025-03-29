# Pendo Dating App

## Overview
Pendo is a modern dating app focused on Eastern and Southern Africa, combining traditional values with modern technology.

## Features

### Core Features
- User Authentication & Profiles
- Matching System
- Real-time Chat
- Tribes & Communities
- Stories
- Location-based Services

### Premium Features
- Advanced Filters
- Unlimited Likes
- Super Likes
- Profile Boost
- See Who Liked You

## Technical Stack

### Mobile App (Flutter)
- State Management: BLoC
- Navigation: Auto Route
- Network: Dio
- Storage: Hive
- Media: Firebase Storage
- Real-time: WebSocket

### Backend (FastAPI)
- Database: PostgreSQL with PostGIS
- Cache: Redis
- Queue: Celery
- Storage: S3
- Search: Elasticsearch

## Project Structure

```
pendo/
├── backend/
│   ├── app/
│   │   ├── api/
│   │   ├── core/
│   │   ├── models/
│   │   └── schemas/
│   ├── alembic/
│   └── tests/
├── pendo_mobile/
│   ├── lib/
│   │   ├── core/
│   │   ├── features/
│   │   └── shared/
│   └── test/
└── Project_documentation/
    ├── api/
    ├── database/
    └── features/
```

## Getting Started

### Prerequisites
- Python 3.9+
- Flutter 3.0+
- PostgreSQL 13+
- Redis 6+

### Setup Backend
1. Create virtual environment
2. Install dependencies: `pip install -r requirements.txt`
3. Setup database: `alembic upgrade head`
4. Run server: `uvicorn app.main:app --reload`

### Setup Mobile App
1. Install dependencies: `flutter pub get`
2. Generate code: `flutter pub run build_runner build`
3. Run app: `flutter run`

## Documentation

### API Documentation
- OpenAPI documentation available at `/docs`
- Detailed API specs in `Project_documentation/api/`

### Database Schema
- Full schema in `Project_documentation/database/`
- Migration history in `backend/alembic/versions/`

### Feature Documentation
- Detailed feature specs in `Project_documentation/features/`
- Implementation guides in respective feature directories

## Testing

### Backend Tests
```bash
pytest backend/tests/
```

### Mobile Tests
```bash
flutter test
```

## Deployment

### Backend Deployment
- Docker containers for all services
- Kubernetes orchestration
- CI/CD with GitHub Actions

### Mobile Deployment
- Android: Google Play Store
- iOS: App Store
- Automated builds with Fastlane

## Contributing
1. Fork the repository
2. Create feature branch
3. Commit changes
4. Create pull request

## License
Proprietary - All rights reserved
