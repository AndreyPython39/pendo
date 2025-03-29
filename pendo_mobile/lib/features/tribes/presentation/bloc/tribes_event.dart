import 'package:equatable/equatable.dart';

abstract class TribesEvent extends Equatable {
  const TribesEvent();

  @override
  List<Object?> get props => [];
}

class LoadTribesEvent extends TribesEvent {
  final int? page;
  final int? limit;
  final Map<String, dynamic>? filters;

  const LoadTribesEvent({
    this.page,
    this.limit,
    this.filters,
  });

  @override
  List<Object?> get props => [page, limit, filters];
}

class CreateTribeEvent extends TribesEvent {
  final String name;
  final String description;
  final String avatar;
  final String coverImage;
  final Map<String, dynamic> settings;

  const CreateTribeEvent({
    required this.name,
    required this.description,
    required this.avatar,
    required this.coverImage,
    required this.settings,
  });

  @override
  List<Object?> get props => [name, description, avatar, coverImage, settings];
}

class UpdateTribeEvent extends TribesEvent {
  final String tribeId;
  final String? name;
  final String? description;
  final String? avatar;
  final String? coverImage;
  final Map<String, dynamic>? settings;

  const UpdateTribeEvent({
    required this.tribeId,
    this.name,
    this.description,
    this.avatar,
    this.coverImage,
    this.settings,
  });

  @override
  List<Object?> get props => [
        tribeId,
        name,
        description,
        avatar,
        coverImage,
        settings,
      ];
}

class DeleteTribeEvent extends TribesEvent {
  final String tribeId;

  const DeleteTribeEvent(this.tribeId);

  @override
  List<Object?> get props => [tribeId];
}

class JoinTribeEvent extends TribesEvent {
  final String tribeId;

  const JoinTribeEvent(this.tribeId);

  @override
  List<Object?> get props => [tribeId];
}

class LeaveTribeEvent extends TribesEvent {
  final String tribeId;

  const LeaveTribeEvent(this.tribeId);

  @override
  List<Object?> get props => [tribeId];
}

class AddModeratorEvent extends TribesEvent {
  final String tribeId;
  final String userId;

  const AddModeratorEvent({
    required this.tribeId,
    required this.userId,
  });

  @override
  List<Object?> get props => [tribeId, userId];
}

class RemoveModeratorEvent extends TribesEvent {
  final String tribeId;
  final String userId;

  const RemoveModeratorEvent({
    required this.tribeId,
    required this.userId,
  });

  @override
  List<Object?> get props => [tribeId, userId];
}

class KickMemberEvent extends TribesEvent {
  final String tribeId;
  final String userId;

  const KickMemberEvent({
    required this.tribeId,
    required this.userId,
  });

  @override
  List<Object?> get props => [tribeId, userId];
}

class CreateEventEvent extends TribesEvent {
  final String tribeId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final double? latitude;
  final double? longitude;
  final Map<String, dynamic>? metadata;

  const CreateEventEvent({
    required this.tribeId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    this.latitude,
    this.longitude,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        tribeId,
        title,
        description,
        startTime,
        endTime,
        location,
        latitude,
        longitude,
        metadata,
      ];
}

class LoadEventsEvent extends TribesEvent {
  final String tribeId;
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadEventsEvent({
    required this.tribeId,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [tribeId, startDate, endDate];
}

class JoinEventEvent extends TribesEvent {
  final String tribeId;
  final String eventId;

  const JoinEventEvent({
    required this.tribeId,
    required this.eventId,
  });

  @override
  List<Object?> get props => [tribeId, eventId];
}

class LeaveEventEvent extends TribesEvent {
  final String tribeId;
  final String eventId;

  const LeaveEventEvent({
    required this.tribeId,
    required this.eventId,
  });

  @override
  List<Object?> get props => [tribeId, eventId];
}

class CreateVoteEvent extends TribesEvent {
  final String tribeId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> options;

  const CreateVoteEvent({
    required this.tribeId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.options,
  });

  @override
  List<Object?> get props => [
        tribeId,
        title,
        description,
        startTime,
        endTime,
        options,
      ];
}

class CastVoteEvent extends TribesEvent {
  final String tribeId;
  final String voteId;
  final String option;

  const CastVoteEvent({
    required this.tribeId,
    required this.voteId,
    required this.option,
  });

  @override
  List<Object?> get props => [tribeId, voteId, option];
}

class LoadActiveVotesEvent extends TribesEvent {
  final String tribeId;

  const LoadActiveVotesEvent(this.tribeId);

  @override
  List<Object?> get props => [tribeId];
}

class LoadTribeStatsEvent extends TribesEvent {
  final String tribeId;

  const LoadTribeStatsEvent(this.tribeId);

  @override
  List<Object?> get props => [tribeId];
}
