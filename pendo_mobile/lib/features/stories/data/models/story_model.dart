import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_model.freezed.dart';
part 'story_model.g.dart';

@freezed
class StoryModel with _$StoryModel {
  const factory StoryModel({
    required int id,
    required int userId,
    required String mediaType,
    required String mediaUrl,
    String? thumbnailUrl,
    String? caption,
    @Default(0) int viewsCount,
    required DateTime expiresAt,
    required DateTime createdAt,
    @Default(false) bool isViewed,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}
