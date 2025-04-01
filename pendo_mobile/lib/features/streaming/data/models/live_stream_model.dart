import 'package:json_annotation/json_annotation.dart';

part 'live_stream_model.g.dart';

@JsonSerializable()
class LiveStreamModel {
  final String id;
  final String title;
  final String? description;
  
  @JsonKey(name: 'streamer_id')
  final String streamerId;
  
  @JsonKey(name: 'stream_url')
  final String streamUrl;
  
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  
  @JsonKey(name: 'viewer_count')
  final int viewerCount;
  
  final String status;
  final List<String>? tags;
  
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;
  
  @JsonKey(name: 'ended_at')
  final DateTime? endedAt;
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  LiveStreamModel({
    required this.id,
    required this.title,
    this.description,
    required this.streamerId,
    required this.streamUrl,
    this.thumbnailUrl,
    required this.viewerCount,
    required this.status,
    this.tags,
    this.startedAt,
    this.endedAt,
    required this.createdAt,
  });

  factory LiveStreamModel.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamModelFromJson(json);

  Map<String, dynamic> toJson() => _$LiveStreamModelToJson(this);
}
