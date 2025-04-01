import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pendo_mobile/features/shared/models/location_model.dart';

part 'tribe.freezed.dart';
part 'tribe.g.dart';

@freezed
class TribeModel with _$TribeModel {
  const factory TribeModel({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'created_by') required String createdBy,
    required String status,
    @JsonKey(name: 'member_count') required int memberCount,
    @JsonKey(name: 'events_count') required int eventsCount,
    @JsonKey(name: 'messages_count') required int messagesCount,
    @JsonKey(name: 'chief_id') String? chiefId,
    @JsonKey(name: 'location') LocationModel? location,
    @JsonKey(name: 'cultural_focus') List<String>? culturalFocus,
    @JsonKey(name: 'traditions') List<String>? traditions,
    @JsonKey(name: 'events') List<TribeEventModel>? events,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _TribeModel;

  factory TribeModel.fromJson(Map<String, dynamic> json) =>
      _$TribeModelFromJson(json);
}

@freezed
class TribeEventModel with _$TribeEventModel {
  const factory TribeEventModel({
    required String id,
    required String title,
    required String description,
    required DateTime date,
    required String location,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'attendees_count') required int attendeesCount,
    @JsonKey(name: 'cultural_type') String? culturalType,
    @JsonKey(name: 'traditions') List<String>? traditions,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TribeEventModel;

  factory TribeEventModel.fromJson(Map<String, dynamic> json) =>
      _$TribeEventModelFromJson(json);
}

@freezed
class TribeVoteModel with _$TribeVoteModel {
  const factory TribeVoteModel({
    required String id,
    @JsonKey(name: 'tribe_id') required String tribeId,
    required String title,
    required String description,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'options') required List<VoteOptionModel> options,
    @JsonKey(name: 'ends_at') required DateTime endsAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TribeVoteModel;

  factory TribeVoteModel.fromJson(Map<String, dynamic> json) =>
      _$TribeVoteModelFromJson(json);
}

@freezed
class VoteOptionModel with _$VoteOptionModel {
  const factory VoteOptionModel({
    required String id,
    required String text,
    @JsonKey(name: 'votes_count') required int votesCount,
  }) = _VoteOptionModel;

  factory VoteOptionModel.fromJson(Map<String, dynamic> json) =>
      _$VoteOptionModelFromJson(json);
}
