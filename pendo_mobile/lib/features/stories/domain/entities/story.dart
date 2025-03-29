import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class StoryModel with _$StoryModel {
  const factory StoryModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String type, // image, video
    required String url,
    String? caption,
    @JsonKey(name: 'cultural_tags') List<String>? culturalTags,
    @JsonKey(name: 'view_count') required int viewCount,
    @JsonKey(name: 'reaction_count') required int reactionCount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}

@freezed
class LiveStreamModel with _$LiveStreamModel {
  const factory LiveStreamModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String title,
    String? description,
    @JsonKey(name: 'stream_url') required String streamUrl,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @JsonKey(name: 'viewer_count') required int viewerCount,
    @JsonKey(name: 'cultural_tags') List<String>? culturalTags,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'started_at') required DateTime startedAt,
  }) = _LiveStreamModel;

  factory LiveStreamModel.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamModelFromJson(json);
}

@freezed
class StoryReactionModel with _$StoryReactionModel {
  const factory StoryReactionModel({
    required String id,
    @JsonKey(name: 'story_id') required String storyId,
    @JsonKey(name: 'user_id') required String userId,
    required String type,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _StoryReactionModel;

  factory StoryReactionModel.fromJson(Map<String, dynamic> json) =>
      _$StoryReactionModelFromJson(json);
}

@freezed
class StreamCommentModel with _$StreamCommentModel {
  const factory StreamCommentModel({
    required String id,
    @JsonKey(name: 'stream_id') required String streamId,
    @JsonKey(name: 'user_id') required String userId,
    required String text,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _StreamCommentModel;

  factory StreamCommentModel.fromJson(Map<String, dynamic> json) =>
      _$StreamCommentModelFromJson(json);
}
