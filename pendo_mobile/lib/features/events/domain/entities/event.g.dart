// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CulturalEventModelImpl _$$CulturalEventModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CulturalEventModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      eventType: json['event_type'] as String,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      imageUrl: json['image_url'] as String?,
      createdBy: json['created_by'] as String,
      attendeesCount: (json['attendees_count'] as num).toInt(),
      maxAttendees: (json['max_attendees'] as num?)?.toInt(),
      culturalSignificance: json['cultural_significance'] as String?,
      traditions: (json['traditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requiredDressCode: json['required_dress_code'] as String?,
      foodPreferences: (json['food_preferences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isPrivate: json['is_private'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$CulturalEventModelImplToJson(
        _$CulturalEventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'event_type': instance.eventType,
      'date': instance.date.toIso8601String(),
      'location': instance.location,
      'image_url': instance.imageUrl,
      'created_by': instance.createdBy,
      'attendees_count': instance.attendeesCount,
      'max_attendees': instance.maxAttendees,
      'cultural_significance': instance.culturalSignificance,
      'traditions': instance.traditions,
      'required_dress_code': instance.requiredDressCode,
      'food_preferences': instance.foodPreferences,
      'is_private': instance.isPrivate,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$EventAttendeeModelImpl _$$EventAttendeeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EventAttendeeModelImpl(
      id: json['id'] as String,
      eventId: json['event_id'] as String,
      userId: json['user_id'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$EventAttendeeModelImplToJson(
        _$EventAttendeeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'user_id': instance.userId,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$EventCommentModelImpl _$$EventCommentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EventCommentModelImpl(
      id: json['id'] as String,
      eventId: json['event_id'] as String,
      userId: json['user_id'] as String,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$EventCommentModelImplToJson(
        _$EventCommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'user_id': instance.userId,
      'text': instance.text,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$EventPhotoModelImpl _$$EventPhotoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EventPhotoModelImpl(
      id: json['id'] as String,
      eventId: json['event_id'] as String,
      userId: json['user_id'] as String,
      photoUrl: json['photo_url'] as String,
      caption: json['caption'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$EventPhotoModelImplToJson(
        _$EventPhotoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'user_id': instance.userId,
      'photo_url': instance.photoUrl,
      'caption': instance.caption,
      'created_at': instance.createdAt.toIso8601String(),
    };
