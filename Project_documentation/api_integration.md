# Pendo Mobile API Integration

## 1. API Architecture

The app uses a RESTful API with the following base structure:

```
Base URL: https://api.pendo.app/v1
```

### Authentication
- JWT token based authentication
- Refresh token mechanism
- Token storage in secure storage

### Error Handling
- Standard error responses
- Retry mechanism for failed requests
- Offline support

## 2. API Endpoints

### Authentication
```
POST /auth/register
POST /auth/login
POST /auth/verify
POST /auth/refresh
POST /auth/logout
```

### Matching
```
GET /profiles
POST /swipes
GET /matches
DELETE /matches/{id}
POST /reports
POST /blocks
DELETE /blocks/{id}
```

### Chat
```
GET /conversations
GET /conversations/{id}/messages
POST /conversations/{id}/messages
DELETE /messages/{id}
PUT /conversations/{id}/read
DELETE /conversations/{id}
```

### Tribes
```
GET /tribes
POST /tribes
PUT /tribes/{id}
DELETE /tribes/{id}
POST /tribes/{id}/join
POST /tribes/{id}/leave
POST /tribes/{id}/events
GET /tribes/{id}/events
POST /tribes/{id}/votes
POST /tribes/{id}/votes/{id}/cast
```

## 3. Models

### User Model
```dart
class UserModel {
  final String id;
  final UserProfile profile;
  final bool isPremium;
  final DateTime createdAt;
  final DateTime lastActive;
  
  // ...
}

class UserProfile {
  final String name;
  final int age;
  final String? bio;
  final List<String> photos;
  final List<String> interests;
  final Location? location;
  
  // ...
}
```

### Match Model
```dart
class MatchModel {
  final String id;
  final UserModel user;
  final DateTime matchedAt;
  final String? conversationId;
  
  // ...
}
```

### Message Model
```dart
class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final String type;
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? metadata;
  
  // ...
}

class ConversationModel {
  final String id;
  final bool isGroup;
  final String? groupName;
  final String? groupAvatar;
  final List<UserModel> participants;
  final String? lastMessageContent;
  final DateTime? lastMessageTime;
  final Map<String, int> unreadCount;
  
  // ...
}
```

### Tribe Model
```dart
class TribeModel {
  final String id;
  final String name;
  final String description;
  final String avatar;
  final String coverImage;
  final UserModel chief;
  final List<UserModel> moderators;
  final List<UserModel> members;
  final Map<String, dynamic> settings;
  
  // ...
}

class TribeEventModel {
  final String id;
  final String tribeId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final double? latitude;
  final double? longitude;
  final List<UserModel> attendees;
  final Map<String, dynamic>? metadata;
  
  // ...
}

class TribeVoteModel {
  final String id;
  final String tribeId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> options;
  final Map<String, List<String>> votes;
  
  // ...
}
```

## 4. API Client

### Base Client
```dart
class ApiClient {
  final Dio _dio;
  final AuthRepository _authRepository;
  
  ApiClient(this._dio, this._authRepository) {
    _setupInterceptors();
  }
  
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }
  
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authRepository.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  
  Future<void> _onError(
    DioError error,
    ErrorInterceptorHandler handler,
  ) async {
    if (error.response?.statusCode == 401) {
      try {
        await _authRepository.refreshToken();
        final token = await _authRepository.getToken();
        error.requestOptions.headers['Authorization'] = 'Bearer $token';
        final response = await _dio.fetch(error.requestOptions);
        handler.resolve(response);
      } catch (e) {
        await _authRepository.logout();
        handler.reject(error);
      }
    } else {
      handler.reject(error);
    }
  }
}
```

### Feature Clients

#### Matching Client
```dart
class MatchingClient {
  final ApiClient _client;
  
  Future<List<UserModel>> getProfiles({
    double? latitude,
    double? longitude,
    double? maxDistance,
    Map<String, dynamic>? filters,
  }) async {
    final response = await _client.get(
      '/profiles',
      queryParameters: {
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        if (maxDistance != null) 'max_distance': maxDistance,
        if (filters != null) ...filters,
      },
    );
    return (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }
  
  // ...
}
```

#### Chat Client
```dart
class ChatClient {
  final ApiClient _client;
  
  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int? page,
    int? limit,
  }) async {
    final response = await _client.get(
      '/conversations/$conversationId/messages',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
      },
    );
    return (response.data as List)
        .map((json) => MessageModel.fromJson(json))
        .toList();
  }
  
  // ...
}
```

#### Tribes Client
```dart
class TribesClient {
  final ApiClient _client;
  
  Future<List<TribeModel>> getTribes({
    int? page,
    int? limit,
    Map<String, dynamic>? filters,
  }) async {
    final response = await _client.get(
      '/tribes',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (filters != null) ...filters,
      },
    );
    return (response.data as List)
        .map((json) => TribeModel.fromJson(json))
        .toList();
  }
  
  // ...
}
```

## 5. WebSocket Integration

### Socket Client
```dart
class SocketClient {
  final WebSocketChannel _channel;
  final AuthRepository _authRepository;
  
  Stream<MessageModel> onMessageReceived() {
    return _channel.stream
        .where((event) => event['type'] == 'message')
        .map((json) => MessageModel.fromJson(json['data']));
  }
  
  Stream<String> onTypingStatusChanged() {
    return _channel.stream
        .where((event) => event['type'] == 'typing')
        .map((json) => json['data']['userId'] as String);
  }
  
  // ...
}
```

### Socket Events
```dart
enum SocketEvent {
  message,
  typing,
  presence,
  tribeUpdate,
  matchUpdate,
}

class SocketMessage {
  final SocketEvent type;
  final Map<String, dynamic> data;
  
  // ...
}
```

## 6. Error Handling

### API Exceptions
```dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? data;
  
  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });
}

class NetworkException extends ApiException {
  const NetworkException({
    String message = 'Network error occurred',
  }) : super(message: message);
}

class AuthException extends ApiException {
  const AuthException({
    String message = 'Authentication failed',
  }) : super(message: message, statusCode: 401);
}
```

### Error Handler
```dart
class ErrorHandler {
  static String getMessage(dynamic error) {
    if (error is ApiException) {
      return error.message;
    } else if (error is SocketException) {
      return 'No internet connection';
    } else {
      return 'An unexpected error occurred';
    }
  }
  
  static bool shouldRetry(dynamic error) {
    return error is NetworkException ||
           error is TimeoutException ||
           (error is ApiException && error.statusCode == 503);
  }
}
```

## 7. Offline Support

### Cache Strategy
```dart
enum CacheStrategy {
  networkOnly,
  cacheFirst,
  networkFirst,
  cacheOnly,
}

class CacheManager {
  final Box<dynamic> _box;
  
  Future<T> get<T>(
    String key,
    Future<T> Function() fetch,
    CacheStrategy strategy,
  ) async {
    switch (strategy) {
      case CacheStrategy.networkOnly:
        return await fetch();
      case CacheStrategy.cacheFirst:
        final cached = await _box.get(key);
        if (cached != null) return cached as T;
        final data = await fetch();
        await _box.put(key, data);
        return data;
      // ...
    }
  }
}
```

### Sync Manager
```dart
class SyncManager {
  final Queue<SyncOperation> _queue;
  
  Future<void> enqueue(SyncOperation operation) async {
    await _queue.add(operation);
    _processQueue();
  }
  
  Future<void> _processQueue() async {
    while (_queue.isNotEmpty) {
      final operation = _queue.first;
      try {
        await operation.execute();
        _queue.removeFirst();
      } catch (e) {
        if (!operation.shouldRetry) {
          _queue.removeFirst();
        }
        break;
      }
    }
  }
}
```

## 8. Testing

### API Tests
```dart
void main() {
  group('ApiClient', () {
    late ApiClient client;
    late MockDio mockDio;
    
    setUp(() {
      mockDio = MockDio();
      client = ApiClient(mockDio);
    });
    
    test('should handle successful request', () async {
      when(mockDio.get('/profiles'))
          .thenAnswer((_) async => Response(data: []));
          
      final result = await client.getProfiles();
      expect(result, isEmpty);
    });
    
    test('should handle error', () async {
      when(mockDio.get('/profiles'))
          .thenThrow(DioError(type: DioErrorType.other));
          
      expect(
        () => client.getProfiles(),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
```

### Mock Responses
```dart
final mockProfiles = [
  {
    'id': '1',
    'profile': {
      'name': 'John',
      'age': 25,
      'photos': ['url1', 'url2'],
    },
  },
  // ...
];

final mockConversation = {
  'id': '1',
  'messages': [
    {
      'id': '1',
      'content': 'Hello',
      'senderId': '1',
      'timestamp': '2025-03-29T22:25:10+03:00',
    },
  ],
};
```
