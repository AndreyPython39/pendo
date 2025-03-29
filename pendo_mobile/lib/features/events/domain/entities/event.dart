import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class CulturalEventModel with _$CulturalEventModel {
  const factory CulturalEventModel({
    required String id,
    required String title,
    required String description,
    @JsonKey(name: 'event_type') required String eventType,
    required DateTime date,
    required String location,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'attendees_count') required int attendeesCount,
    @JsonKey(name: 'max_attendees') int? maxAttendees,
    @JsonKey(name: 'cultural_significance') String? culturalSignificance,
    @JsonKey(name: 'traditions') List<String>? traditions,
    @JsonKey(name: 'required_dress_code') String? requiredDressCode,
    @JsonKey(name: 'food_preferences') List<String>? foodPreferences,
    @JsonKey(name: 'is_private') required bool isPrivate,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _CulturalEventModel;

  factory CulturalEventModel.fromJson(Map<String, dynamic> json) =>
      _$CulturalEventModelFromJson(json);
}

@freezed
class EventAttendeeModel with _$EventAttendeeModel {
  const factory EventAttendeeModel({
    required String id,
    @JsonKey(name: 'event_id') required String eventId,
    @JsonKey(name: 'user_id') required String userId,
    required String status, // going, maybe, not_going
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _EventAttendeeModel;

  factory EventAttendeeModel.fromJson(Map<String, dynamic> json) =>
      _$EventAttendeeModelFromJson(json);
}

@freezed
class EventCommentModel with _$EventCommentModel {
  const factory EventCommentModel({
    required String id,
    @JsonKey(name: 'event_id') required String eventId,
    @JsonKey(name: 'user_id') required String userId,
    required String text,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _EventCommentModel;

  factory EventCommentModel.fromJson(Map<String, dynamic> json) =>
      _$EventCommentModelFromJson(json);
}

@freezed
class EventPhotoModel with _$EventPhotoModel {
  const factory EventPhotoModel({
    required String id,
    @JsonKey(name: 'event_id') required String eventId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'photo_url') required String photoUrl,
    String? caption,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _EventPhotoModel;

  factory EventPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$EventPhotoModelFromJson(json);
}
