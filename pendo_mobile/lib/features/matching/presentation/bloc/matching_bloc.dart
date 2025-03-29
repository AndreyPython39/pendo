import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/features/matching/domain/repositories/matching_repository.dart';
import 'package:pendo_mobile/features/matching/presentation/bloc/matching_event.dart';
import 'package:pendo_mobile/features/matching/presentation/bloc/matching_state.dart';

class MatchingBloc extends Bloc<MatchingEvent, MatchingState> {
  final MatchingRepository _matchingRepository;

  MatchingBloc(this._matchingRepository) : super(MatchingInitial()) {
    on<LoadProfilesEvent>(_onLoadProfiles);
    on<SwipeEvent>(_onSwipe);
    on<LoadMatchesEvent>(_onLoadMatches);
    on<UnmatchEvent>(_onUnmatch);
    on<ReportUserEvent>(_onReportUser);
    on<BlockUserEvent>(_onBlockUser);
    on<UnblockUserEvent>(_onUnblockUser);
    on<BoostProfileEvent>(_onBoostProfile);
    on<RewindEvent>(_onRewind);
    on<SuperLikeEvent>(_onSuperLike);
    on<CheckRemainingActionsEvent>(_onCheckRemainingActions);
  }

  Future<void> _onLoadProfiles(
    LoadProfilesEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      final profiles = await _matchingRepository.getProfiles(
        latitude: event.latitude,
        longitude: event.longitude,
        maxDistance: event.maxDistance,
        filters: event.filters,
      );
      emit(ProfilesLoaded(profiles: profiles));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onSwipe(
    SwipeEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      await _matchingRepository.swipe(
        userId: event.userId,
        action: event.action,
      );
      
      // Check if it's a match
      final matches = await _matchingRepository.getMatches(limit: 1);
      final isMatch = matches.isNotEmpty && 
                     matches.first.user.id.toString() == event.userId;
      
      emit(SwipeSuccess(
        action: event.action,
        isMatch: isMatch,
        match: isMatch ? matches.first : null,
      ));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onLoadMatches(
    LoadMatchesEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      final matches = await _matchingRepository.getMatches(
        page: event.page,
        limit: event.limit,
      );
      emit(MatchesLoaded(matches: matches));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onUnmatch(
    UnmatchEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      await _matchingRepository.unmatch(event.matchId);
      emit(UnmatchSuccess(event.matchId));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onReportUser(
    ReportUserEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      await _matchingRepository.reportUser(
        userId: event.userId,
        reason: event.reason,
        description: event.description,
      );
      emit(ReportSuccess(event.userId));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onBlockUser(
    BlockUserEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      await _matchingRepository.blockUser(event.userId);
      emit(BlockSuccess(event.userId));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onUnblockUser(
    UnblockUserEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      await _matchingRepository.unblockUser(event.userId);
      emit(UnblockSuccess(event.userId));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onBoostProfile(
    BoostProfileEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      await _matchingRepository.boostProfile(
        duration: event.duration,
        paymentId: event.paymentId,
      );
      emit(BoostSuccess(
        duration: event.duration,
        expiresAt: DateTime.now().add(Duration(minutes: event.duration)),
      ));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onRewind(
    RewindEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      await _matchingRepository.rewind();
      emit(RewindSuccess());
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onSuperLike(
    SuperLikeEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      await _matchingRepository.superLike(event.userId);
      emit(SuperLikeSuccess(event.userId));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }

  Future<void> _onCheckRemainingActions(
    CheckRemainingActionsEvent event,
    Emitter<MatchingState> emit,
  ) async {
    try {
      emit(MatchingLoading());
      final actions = await _matchingRepository.getRemainingActions();
      emit(RemainingActionsLoaded(actions));
    } catch (e) {
      emit(MatchingError(e.toString()));
    }
  }
}
