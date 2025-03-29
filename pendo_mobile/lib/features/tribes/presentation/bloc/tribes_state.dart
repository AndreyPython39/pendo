import 'package:equatable/equatable.dart';
import 'package:pendo_mobile/features/tribes/data/models/tribe_model.dart';

abstract class TribesState extends Equatable {
  const TribesState();

  @override
  List<Object?> get props => [];
}

class TribesInitial extends TribesState {}

class TribesLoading extends TribesState {}

class TribesLoaded extends TribesState {
  final List<TribeModel> tribes;
  final bool hasMore;

  const TribesLoaded({
    required this.tribes,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [tribes, hasMore];
}

class TribeCreated extends TribesState {
  final TribeModel tribe;

  const TribeCreated(this.tribe);

  @override
  List<Object?> get props => [tribe];
}

class TribeUpdated extends TribesState {
  final TribeModel tribe;

  const TribeUpdated(this.tribe);

  @override
  List<Object?> get props => [tribe];
}

class TribeDeleted extends TribesState {
  final String tribeId;

  const TribeDeleted(this.tribeId);

  @override
  List<Object?> get props => [tribeId];
}

class TribeJoined extends TribesState {
  final String tribeId;

  const TribeJoined(this.tribeId);

  @override
  List<Object?> get props => [tribeId];
}

class TribeLeft extends TribesState {
  final String tribeId;

  const TribeLeft(this.tribeId);

  @override
  List<Object?> get props => [tribeId];
}

class ModeratorAdded extends TribesState {
  final String tribeId;
  final String userId;

  const ModeratorAdded({
    required this.tribeId,
    required this.userId,
  });

  @override
  List<Object?> get props => [tribeId, userId];
}

class ModeratorRemoved extends TribesState {
  final String tribeId;
  final String userId;

  const ModeratorRemoved({
    required this.tribeId,
    required this.userId,
  });

  @override
  List<Object?> get props => [tribeId, userId];
}

class MemberKicked extends TribesState {
  final String tribeId;
  final String userId;

  const MemberKicked({
    required this.tribeId,
    required this.userId,
  });

  @override
  List<Object?> get props => [tribeId, userId];
}

class EventCreated extends TribesState {
  final TribeEventModel event;

  const EventCreated(this.event);

  @override
  List<Object?> get props => [event];
}

class EventsLoaded extends TribesState {
  final List<TribeEventModel> events;

  const EventsLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class EventJoined extends TribesState {
  final String eventId;

  const EventJoined(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

class EventLeft extends TribesState {
  final String eventId;

  const EventLeft(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

class VoteCreated extends TribesState {
  final TribeVoteModel vote;

  const VoteCreated(this.vote);

  @override
  List<Object?> get props => [vote];
}

class VoteCasted extends TribesState {
  final String voteId;
  final String option;

  const VoteCasted({
    required this.voteId,
    required this.option,
  });

  @override
  List<Object?> get props => [voteId, option];
}

class ActiveVotesLoaded extends TribesState {
  final List<TribeVoteModel> votes;

  const ActiveVotesLoaded(this.votes);

  @override
  List<Object?> get props => [votes];
}

class TribeStatsLoaded extends TribesState {
  final Map<String, dynamic> stats;

  const TribeStatsLoaded(this.stats);

  @override
  List<Object?> get props => [stats];
}

class TribesError extends TribesState {
  final String message;

  const TribesError(this.message);

  @override
  List<Object?> get props => [message];
}
