import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pendo_mobile/features/matching/bloc/matching_bloc.dart';
import 'package:pendo_mobile/features/matching/data/repositories/matching_repository.dart';
import 'package:pendo_mobile/features/matching/data/models/card_model.dart';

class MockMatchingRepository extends Mock implements MatchingRepository {}

void main() {
  late MatchingBloc matchingBloc;
  late MockMatchingRepository mockMatchingRepository;

  setUp(() {
    mockMatchingRepository = MockMatchingRepository();
    matchingBloc = MatchingBloc(matchingRepository: mockMatchingRepository);
  });

  tearDown(() {
    matchingBloc.close();
  });

  group('MatchingBloc', () {
    final testCards = [
      CardModel(
        id: '1',
        name: 'Test User 1',
        age: 25,
        bio: 'Test bio 1',
        photos: ['photo1.jpg'],
      ),
      CardModel(
        id: '2',
        name: 'Test User 2',
        age: 28,
        bio: 'Test bio 2',
        photos: ['photo2.jpg'],
      ),
    ];

    test('initial state is MatchingInitial', () {
      expect(matchingBloc.state, equals(MatchingInitial()));
    });

    blocTest<MatchingBloc, MatchingState>(
      'emits [MatchingLoading, MatchingLoaded] when loading cards succeeds',
      build: () {
        when(mockMatchingRepository.getCards())
            .thenAnswer((_) async => testCards);
        return matchingBloc;
      },
      act: (bloc) => bloc.add(LoadCards()),
      expect: () => [
        MatchingLoading(),
        MatchingLoaded(cards: testCards),
      ],
    );

    blocTest<MatchingBloc, MatchingState>(
      'emits [MatchingLoading, MatchingError] when loading cards fails',
      build: () {
        when(mockMatchingRepository.getCards())
            .thenThrow(Exception('Failed to load cards'));
        return matchingBloc;
      },
      act: (bloc) => bloc.add(LoadCards()),
      expect: () => [
        MatchingLoading(),
        MatchingError(message: 'Failed to load cards'),
      ],
    );

    blocTest<MatchingBloc, MatchingState>(
      'emits correct states when swiping right',
      build: () {
        when(mockMatchingRepository.swipe(
          userId: '1',
          direction: SwipeDirection.right,
        )).thenAnswer((_) async => true);
        return matchingBloc;
      },
      seed: () => MatchingLoaded(cards: testCards),
      act: (bloc) => bloc.add(SwipeCard(
        userId: '1',
        direction: SwipeDirection.right,
      )),
      expect: () => [
        MatchingLoading(),
        MatchingLoaded(cards: testCards.sublist(1)),
      ],
    );

    blocTest<MatchingBloc, MatchingState>(
      'emits correct states when super liking',
      build: () {
        when(mockMatchingRepository.superLike(userId: '1'))
            .thenAnswer((_) async => true);
        return matchingBloc;
      },
      seed: () => MatchingLoaded(cards: testCards),
      act: (bloc) => bloc.add(SuperLikeCard(userId: '1')),
      expect: () => [
        MatchingLoading(),
        MatchingLoaded(cards: testCards.sublist(1)),
      ],
    );

    blocTest<MatchingBloc, MatchingState>(
      'emits correct states when boosting profile',
      build: () {
        when(mockMatchingRepository.boost())
            .thenAnswer((_) async => DateTime.now().add(Duration(minutes: 30)));
        return matchingBloc;
      },
      act: (bloc) => bloc.add(BoostProfile()),
      expect: () => [
        MatchingLoading(),
        MatchingBoosted(
          endTime: any(named: 'endTime'),
        ),
      ],
    );

    blocTest<MatchingBloc, MatchingState>(
      'emits correct states when updating preferences',
      build: () {
        when(mockMatchingRepository.updatePreferences(any))
            .thenAnswer((_) async => true);
        return matchingBloc;
      },
      act: (bloc) => bloc.add(UpdatePreferences(
        ageRange: AgeRange(min: 20, max: 35),
        distance: 50,
        gender: ['female'],
      )),
      expect: () => [
        MatchingLoading(),
        MatchingSuccess(),
      ],
    );
  });
}
