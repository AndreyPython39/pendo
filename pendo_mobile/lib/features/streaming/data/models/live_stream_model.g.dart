// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveStreamModel _$LiveStreamModelFromJson(Map<String, dynamic> json) =>
    LiveStreamModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      streamerId: json['streamer_id'] as String,
      streamUrl: json['stream_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      viewerCount: (json['viewer_count'] as num).toInt(),
      status: json['status'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      endedAt: json['ended_at'] == null
          ? null
          : DateTime.parse(json['ended_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$LiveStreamModelToJson(LiveStreamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'streamer_id': instance.streamerId,
      'stream_url': instance.streamUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'viewer_count': instance.viewerCount,
      'status': instance.status,
      'tags': instance.tags,
      'started_at': instance.startedAt?.toIso8601String(),
      'ended_at': instance.endedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
