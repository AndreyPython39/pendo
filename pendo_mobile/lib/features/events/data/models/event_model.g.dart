// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      maxAttendees: (json['maxAttendees'] as num?)?.toInt(),
      coverImage: json['coverImage'] as String?,
      creatorId: json['creatorId'] as String,
      attendees:
          (json['attendees'] as List<dynamic>).map((e) => e as String).toList(),
      settings: json['settings'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'maxAttendees': instance.maxAttendees,
      'coverImage': instance.coverImage,
      'creatorId': instance.creatorId,
      'attendees': instance.attendees,
      'settings': instance.settings,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$EventAttendeeModelImpl _$$EventAttendeeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EventAttendeeModelImpl(
      userId: json['userId'] as String,
      eventId: json['eventId'] as String,
      status: json['status'] as String,
      note: json['note'] as String?,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$$EventAttendeeModelImplToJson(
        _$EventAttendeeModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'eventId': instance.eventId,
      'status': instance.status,
      'note': instance.note,
      'joinedAt': instance.joinedAt.toIso8601String(),
    };

_$EventCommentModelImpl _$$EventCommentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EventCommentModelImpl(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$EventCommentModelImplToJson(
        _$EventCommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'userId': instance.userId,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'attachments': instance.attachments,
    };
