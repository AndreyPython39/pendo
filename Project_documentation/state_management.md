# Pendo Mobile State Management

## 1. Architecture Overview

The app uses a clean architecture approach with BLoC pattern, optimized for African market:
- Presentation Layer (UI with cultural elements)
- Domain Layer (Business Logic)
- Data Layer (Data Access)

## 2. BLoC Pattern Implementation

### Core Concepts
- Events: User actions or system events
- States: UI states that can be emitted
- BLoC: Business logic component that processes events and emits states

### Example Flow
```dart
User Action -> Event -> BLoC -> State -> UI Update
```

## 3. Feature BLoCs

### Matching BLoC
```dart
// Events
LoadProfilesEvent
SwipeEvent
UnmatchEvent
ReportUserEvent
BlockUserEvent
BoostProfileEvent

// States
MatchingInitial
MatchingLoading
ProfilesLoaded
SwipeSuccess
UnmatchSuccess
MatchingError
```

### Chat BLoC
```dart
// Events
LoadConversationsEvent
LoadMessagesEvent
SendMessageEvent
DeleteMessageEvent
MarkAsReadEvent
StartTypingEvent

// States
ChatInitial
ChatLoading
ConversationsLoaded
MessagesLoaded
MessageSent
ChatError
```

### Tribes BLoC
```dart
// Events
LoadTribesEvent
CreateTribeEvent
JoinTribeEvent
LoadEventsEvent
CreateVoteEvent
CastVoteEvent

// States
TribesInitial
TribesLoading
TribesLoaded
TribeCreated
EventsLoaded
VoteCreated
TribesError
```

### Cultural Features BLoC
```dart
// Events
LoadCulturalPromptsEvent
AnswerPromptEvent
ShareCulturalContentEvent
JoinTraditionalEventEvent

// States
CulturalPromptsLoaded
PromptAnswered
ContentShared
EventJoined
```

### Stories BLoC
```dart
// Events
CreateStoryEvent
ViewStoryEvent
ReactToStoryEvent
DeleteStoryEvent

// States
StoriesLoaded
StoryCreated
StoryViewed
StoryReactionAdded
```

### Live Streaming BLoC
```dart
// Events
StartStreamEvent
JoinStreamEvent
SendReactionEvent
EndStreamEvent

// States
StreamStarted
StreamJoined
ReactionSent
StreamEnded
```

### Virtual Gifts BLoC
```dart
// Events
SendGiftEvent
ReceiveGiftEvent
ViewGiftHistoryEvent

// States
GiftSent
GiftReceived
GiftHistoryLoaded
```

## 4. State Management Rules

### 1. Single Source of Truth
- Each feature has one BLoC responsible for its state
- States are immutable
- State changes are unidirectional

### 2. Error Handling
```dart
try {
  // Business logic
} catch (e) {
  emit(ErrorState(e.toString()));
}
```

### 3. Loading States
- Show loading indicator for async operations
- Maintain previous state data during loading
- Handle empty states appropriately

### 4. State Persistence
- Cache necessary states locally
- Handle app lifecycle changes
- Restore state after app restart

## 5. Dependencies

### Required Packages
```yaml
dependencies:
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  get_it: ^7.6.0
  injectable: ^2.1.2
```

### BLoC Dependencies
```dart
@injectable
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureRepository _repository;
  
  FeatureBloc(this._repository) : super(FeatureInitial());
}
```

## 6. Testing

### BLoC Tests
```dart
void main() {
  group('FeatureBloc', () {
    late FeatureBloc bloc;
    late MockRepository repository;

    setUp(() {
      repository = MockRepository();
      bloc = FeatureBloc(repository);
    });

    blocTest<FeatureBloc, FeatureState>(
      'emits [Loading, Loaded] when successful',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadEvent()),
      expect: () => [
        FeatureLoading(),
        FeatureLoaded(),
      ],
    );
  });
}
```

### Integration Tests
```dart
void main() {
  testWidgets('Feature flow test', (tester) async {
    await tester.pumpWidget(MyApp());
    
    // Trigger events
    await tester.tap(find.byType(Button));
    await tester.pump();
    
    // Verify states
    expect(find.byType(LoadingIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(SuccessView), findsOneWidget);
  });
}
```

## 7. Best Practices

### 1. Event Handling
- Keep events focused and specific
- Document event parameters
- Validate event data

### 2. State Design
- Make states immutable
- Include all necessary data
- Use sealed classes when possible

### 3. BLoC Organization
- One BLoC per feature
- Keep BLoCs focused
- Handle cleanup in close()

### 4. Error Handling
- Define error states
- Include error messages
- Provide recovery actions

### 5. Performance
- Debounce frequent events
- Cache results when appropriate
- Clean up subscriptions

## 8. Code Examples

### Event Definition
```dart
abstract class FeatureEvent extends Equatable {
  const FeatureEvent();
  
  @override
  List<Object?> get props => [];
}

class LoadFeatureEvent extends FeatureEvent {
  final String id;
  
  const LoadFeatureEvent(this.id);
  
  @override
  List<Object?> get props => [id];
}
```

### State Definition
```dart
abstract class FeatureState extends Equatable {
  const FeatureState();
  
  @override
  List<Object?> get props => [];
}

class FeatureLoaded extends FeatureState {
  final List<Item> items;
  
  const FeatureLoaded(this.items);
  
  @override
  List<Object?> get props => [items];
}
```

### BLoC Implementation
```dart
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureRepository _repository;
  
  FeatureBloc(this._repository) : super(FeatureInitial()) {
    on<LoadFeatureEvent>(_onLoadFeature);
  }
  
  Future<void> _onLoadFeature(
    LoadFeatureEvent event,
    Emitter<FeatureState> emit,
  ) async {
    try {
      emit(FeatureLoading());
      final items = await _repository.getItems(event.id);
      emit(FeatureLoaded(items));
    } catch (e) {
      emit(FeatureError(e.toString()));
    }
  }
  
  @override
  Future<void> close() {
    // Cleanup
    return super.close();
  }
}
```

### UI Integration
```dart
class FeaturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeatureBloc, FeatureState>(
      listener: (context, state) {
        if (state is FeatureError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return switch (state) {
          FeatureLoading() => const LoadingIndicator(),
          FeatureLoaded(items: final items) => ItemsList(items: items),
          FeatureError() => const ErrorView(),
          _ => const SizedBox(),
        };
      },
    );
  }
}

## 9. Cultural Integration

### Language Management
```dart
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final List<String> supportedLocales = ['en', 'sw', 'zu', 'ru'];
  
  // Events
  ChangeLanguageEvent
  LoadTranslationsEvent
  
  // States
  LanguageChanged
  TranslationsLoaded
}
```

### Cultural Content
```dart
class CulturalContentBloc extends Bloc<CulturalContentEvent, CulturalContentState> {
  // Events
  LoadCulturalContentEvent
  ShareTraditionalContentEvent
  
  // States
  CulturalContentLoaded
  ContentShared
}
```

## 10. Innovation Features

### Women First Mode
```dart
class WomenFirstBloc extends Bloc<WomenFirstEvent, WomenFirstState> {
  // Events
  ToggleWomenFirstMode
  InitiateContactEvent
  
  // States
  WomenFirstEnabled
  ContactInitiated
}
```

### Location Features
```dart
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  // Events
  UpdateLocationEvent
  SearchNearbyEvent
  JoinLocalEventEvent
  
  // States
  LocationUpdated
  NearbyUsersFound
  EventJoined
}
```

## 11. Premium Features

### Subscription Management
```dart
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  // Events
  PurchaseSubscriptionEvent
  RestorePurchaseEvent
  
  // States
  SubscriptionActive
  PurchaseRestored
}
```

### Boost Management
```dart
class BoostBloc extends Bloc<BoostEvent, BoostState> {
  // Events
  ActivateBoostEvent
  CheckBoostStatusEvent
  
  // States
  BoostActivated
  BoostExpired
}
```

## 12. Testing

### Cultural Feature Tests
```dart
void main() {
  group('CulturalBloc', () {
    test('should load cultural prompts', () {
      // Test implementation
    });
    
    test('should handle traditional events', () {
      // Test implementation
    });
  });
}
```

### Innovation Tests
```dart
void main() {
  group('WomenFirstBloc', () {
    test('should enable women first mode', () {
      // Test implementation
    });
    
    test('should handle contact initiation', () {
      // Test implementation
    });
  });
}
```

## 13. Error Handling

### Cultural Context Errors
```dart
class CulturalError extends Error {
  final String message;
  final String culturalContext;
  
  CulturalError(this.message, this.culturalContext);
}
```

### Location Errors
```dart
class LocationError extends Error {
  final String message;
  final double? latitude;
  final double? longitude;
  
  LocationError(this.message, {this.latitude, this.longitude});
}
```

## 14. Best Practices

### Cultural Sensitivity
- Handle cultural content appropriately
- Respect local customs in UI/UX
- Provide cultural context where needed
- Support multiple languages

### Performance
- Optimize for various network conditions
- Handle offline scenarios
- Cache cultural content
- Efficient image loading

### Security
- Protect user cultural data
- Secure location information
- Safe content sharing
- Privacy controls
