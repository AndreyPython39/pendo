// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryModelImpl _$$StoryModelImplFromJson(Map<String, dynamic> json) =>
    _$StoryModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      caption: json['caption'] as String?,
      culturalTags: (json['cultural_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      viewCount: (json['view_count'] as num).toInt(),
      reactionCount: (json['reaction_count'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$$StoryModelImplToJson(_$StoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'type': instance.type,
      'url': instance.url,
      'caption': instance.caption,
      'cultural_tags': instance.culturalTags,
      'view_count': instance.viewCount,
      'reaction_count': instance.reactionCount,
      'created_at': instance.createdAt.toIso8601String(),
      'expires_at': instance.expiresAt.toIso8601String(),
    };

_$LiveStreamModelImpl _$$LiveStreamModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LiveStreamModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      streamUrl: json['stream_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      viewerCount: (json['viewer_count'] as num).toInt(),
      culturalTags: (json['cultural_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isActive: json['is_active'] as bool,
      startedAt: DateTime.parse(json['started_at'] as String),
    );

Map<String, dynamic> _$$LiveStreamModelImplToJson(
        _$LiveStreamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'stream_url': instance.streamUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'viewer_count': instance.viewerCount,
      'cultural_tags': instance.culturalTags,
      'is_active': instance.isActive,
      'started_at': instance.startedAt.toIso8601String(),
    };

_$StoryReactionModelImpl _$$StoryReactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StoryReactionModelImpl(
      id: json['id'] as String,
      storyId: json['story_id'] as String,
      userId: json['user_id'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$StoryReactionModelImplToJson(
        _$StoryReactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'story_id': instance.storyId,
      'user_id': instance.userId,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$StreamCommentModelImpl _$$StreamCommentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StreamCommentModelImpl(
      id: json['id'] as String,
      streamId: json['stream_id'] as String,
      userId: json['user_id'] as String,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$StreamCommentModelImplToJson(
        _$StreamCommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stream_id': instance.streamId,
      'user_id': instance.userId,
      'text': instance.text,
      'created_at': instance.createdAt.toIso8601String(),
    };
