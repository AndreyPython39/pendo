import 'package:equatable/equatable.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';
import 'package:pendo_mobile/features/matching/data/models/match_model.dart';

abstract class MatchingState extends Equatable {
  const MatchingState();

  @override
  List<Object?> get props => [];
}

class MatchingInitial extends MatchingState {}

class MatchingLoading extends MatchingState {}

class ProfilesLoaded extends MatchingState {
  final List<UserModel> profiles;
  final bool hasMore;

  const ProfilesLoaded({
    required this.profiles,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [profiles, hasMore];
}

class MatchesLoaded extends MatchingState {
  final List<MatchModel> matches;
  final bool hasMore;

  const MatchesLoaded({
    required this.matches,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [matches, hasMore];
}

class SwipeSuccess extends MatchingState {
  final String action;
  final bool isMatch;
  final MatchModel? match;

  const SwipeSuccess({
    required this.action,
    required this.isMatch,
    this.match,
  });

  @override
  List<Object?> get props => [action, isMatch, match];
}

class UnmatchSuccess extends MatchingState {
  final String matchId;

  const UnmatchSuccess(this.matchId);

  @override
  List<Object?> get props => [matchId];
}

class ReportSuccess extends MatchingState {
  final String userId;

  const ReportSuccess(this.userId);

  @override
  List<Object?> get props => [userId];
}

class BlockSuccess extends MatchingState {
  final String userId;

  const BlockSuccess(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UnblockSuccess extends MatchingState {
  final String userId;

  const UnblockSuccess(this.userId);

  @override
  List<Object?> get props => [userId];
}

class BoostSuccess extends MatchingState {
  final int duration;
  final DateTime expiresAt;

  const BoostSuccess({
    required this.duration,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [duration, expiresAt];
}

class RewindSuccess extends MatchingState {}

class SuperLikeSuccess extends MatchingState {
  final String userId;

  const SuperLikeSuccess(this.userId);

  @override
  List<Object?> get props => [userId];
}

class RemainingActionsLoaded extends MatchingState {
  final Map<String, int> actions;

  const RemainingActionsLoaded(this.actions);

  @override
  List<Object?> get props => [actions];
}

class MatchingError extends MatchingState {
  final String message;

  const MatchingError(this.message);

  @override
  List<Object?> get props => [message];
}
