import 'package:equatable/equatable.dart';

abstract class MatchingEvent extends Equatable {
  const MatchingEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfilesEvent extends MatchingEvent {
  final double? latitude;
  final double? longitude;
  final double? maxDistance;
  final Map<String, dynamic>? filters;

  const LoadProfilesEvent({
    this.latitude,
    this.longitude,
    this.maxDistance,
    this.filters,
  });

  @override
  List<Object?> get props => [latitude, longitude, maxDistance, filters];
}

class SwipeEvent extends MatchingEvent {
  final String userId;
  final String action; // like, pass, superLike

  const SwipeEvent({
    required this.userId,
    required this.action,
  });

  @override
  List<Object?> get props => [userId, action];
}

class LoadMatchesEvent extends MatchingEvent {
  final int? page;
  final int? limit;

  const LoadMatchesEvent({
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [page, limit];
}

class UnmatchEvent extends MatchingEvent {
  final String matchId;

  const UnmatchEvent(this.matchId);

  @override
  List<Object?> get props => [matchId];
}

class ReportUserEvent extends MatchingEvent {
  final String userId;
  final String reason;
  final String? description;

  const ReportUserEvent({
    required this.userId,
    required this.reason,
    this.description,
  });

  @override
  List<Object?> get props => [userId, reason, description];
}

class BlockUserEvent extends MatchingEvent {
  final String userId;

  const BlockUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UnblockUserEvent extends MatchingEvent {
  final String userId;

  const UnblockUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class BoostProfileEvent extends MatchingEvent {
  final int duration;
  final String paymentId;

  const BoostProfileEvent({
    required this.duration,
    required this.paymentId,
  });

  @override
  List<Object?> get props => [duration, paymentId];
}

class RewindEvent extends MatchingEvent {}

class SuperLikeEvent extends MatchingEvent {
  final String userId;

  const SuperLikeEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class CheckRemainingActionsEvent extends MatchingEvent {}
