import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String id,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
    double? latitude,
    double? longitude,
    int? maxAttendees,
    String? coverImage,
    required String creatorId,
    required List<String> attendees,
    required Map<String, dynamic> settings,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}

@freezed
class EventAttendeeModel with _$EventAttendeeModel {
  const factory EventAttendeeModel({
    required String userId,
    required String eventId,
    required String status,
    String? note,
    required DateTime joinedAt,
  }) = _EventAttendeeModel;

  factory EventAttendeeModel.fromJson(Map<String, dynamic> json) =>
      _$EventAttendeeModelFromJson(json);
}

@freezed
class EventCommentModel with _$EventCommentModel {
  const factory EventCommentModel({
    required String id,
    required String eventId,
    required String userId,
    required String content,
    required DateTime createdAt,
    List<String>? attachments,
  }) = _EventCommentModel;

  factory EventCommentModel.fromJson(Map<String, dynamic> json) =>
      _$EventCommentModelFromJson(json);
}
