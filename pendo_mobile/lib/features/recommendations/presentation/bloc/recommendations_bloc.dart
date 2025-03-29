import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/recommendation.dart';
import '../../domain/repositories/recommendations_repository.dart';
import '../../../shared/errors/failure.dart';

// Events
abstract class RecommendationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadRecommendations extends RecommendationsEvent {}

class LoadMoreRecommendations extends RecommendationsEvent {}

class LikeRecommendation extends RecommendationsEvent {
  final int userId;

  LikeRecommendation(this.userId);

  @override
  List<Object?> get props => [userId];
}

class PassRecommendation extends RecommendationsEvent {
  final int userId;

  PassRecommendation(this.userId);

  @override
  List<Object?> get props => [userId];
}

// States
abstract class RecommendationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecommendationsInitial extends RecommendationsState {}

class RecommendationsLoading extends RecommendationsState {}

class RecommendationsLoaded extends RecommendationsState {
  final List<Recommendation> recommendations;
  final bool hasReachedMax;

  RecommendationsLoaded({
    required this.recommendations,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [recommendations, hasReachedMax];

  RecommendationsLoaded copyWith({
    List<Recommendation>? recommendations,
    bool? hasReachedMax,
  }) {
    return RecommendationsLoaded(
      recommendations: recommendations ?? this.recommendations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class RecommendationsError extends RecommendationsState {
  final String message;

  RecommendationsError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class RecommendationsBloc
    extends Bloc<RecommendationsEvent, RecommendationsState> {
  final RecommendationsRepository repository;
  static const _pageSize = 20;

  RecommendationsBloc({required this.repository})
      : super(RecommendationsInitial()) {
    on<LoadRecommendations>(_onLoadRecommendations);
    on<LoadMoreRecommendations>(_onLoadMoreRecommendations);
    on<LikeRecommendation>(_onLikeRecommendation);
    on<PassRecommendation>(_onPassRecommendation);
  }

  Future<void> _onLoadRecommendations(
    LoadRecommendations event,
    Emitter<RecommendationsState> emit,
  ) async {
    emit(RecommendationsLoading());

    try {
      final recommendations = await repository.getRecommendations(
        limit: _pageSize,
        offset: 0,
      );

      emit(RecommendationsLoaded(
        recommendations: recommendations,
        hasReachedMax: recommendations.length < _pageSize,
      ));
    } on Failure catch (failure) {
      emit(RecommendationsError(failure.message));
    } catch (e) {
      emit(RecommendationsError('Произошла ошибка при загрузке рекомендаций'));
    }
  }

  Future<void> _onLoadMoreRecommendations(
    LoadMoreRecommendations event,
    Emitter<RecommendationsState> emit,
  ) async {
    if (state is RecommendationsLoaded) {
      final currentState = state as RecommendationsLoaded;
      if (currentState.hasReachedMax) return;

      try {
        final moreRecommendations = await repository.getRecommendations(
          limit: _pageSize,
          offset: currentState.recommendations.length,
        );

        emit(
          moreRecommendations.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : RecommendationsLoaded(
                  recommendations: [
                    ...currentState.recommendations,
                    ...moreRecommendations,
                  ],
                  hasReachedMax: moreRecommendations.length < _pageSize,
                ),
        );
      } on Failure catch (failure) {
        emit(RecommendationsError(failure.message));
      } catch (e) {
        emit(RecommendationsError(
            'Произошла ошибка при загрузке дополнительных рекомендаций'));
      }
    }
  }

  Future<void> _onLikeRecommendation(
    LikeRecommendation event,
    Emitter<RecommendationsState> emit,
  ) async {
    if (state is RecommendationsLoaded) {
      try {
        await repository.likeUser(event.userId);

        final currentState = state as RecommendationsLoaded;
        final updatedRecommendations = currentState.recommendations
            .where((r) => r.user.id != event.userId)
            .toList();

        emit(currentState.copyWith(recommendations: updatedRecommendations));

        // Если рекомендаций мало, подгружаем еще
        if (updatedRecommendations.length < 5) {
          add(LoadMoreRecommendations());
        }
      } on Failure catch (failure) {
        emit(RecommendationsError(failure.message));
      } catch (e) {
        emit(RecommendationsError('Произошла ошибка при отправке лайка'));
      }
    }
  }

  Future<void> _onPassRecommendation(
    PassRecommendation event,
    Emitter<RecommendationsState> emit,
  ) async {
    if (state is RecommendationsLoaded) {
      try {
        await repository.passUser(event.userId);

        final currentState = state as RecommendationsLoaded;
        final updatedRecommendations = currentState.recommendations
            .where((r) => r.user.id != event.userId)
            .toList();

        emit(currentState.copyWith(recommendations: updatedRecommendations));

        // Если рекомендаций мало, подгружаем еще
        if (updatedRecommendations.length < 5) {
          add(LoadMoreRecommendations());
        }
      } on Failure catch (failure) {
        emit(RecommendationsError(failure.message));
      } catch (e) {
        emit(RecommendationsError('Произошла ошибка при пропуске профиля'));
      }
    }
  }
}
