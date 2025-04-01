// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tribe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TribeModelImpl _$$TribeModelImplFromJson(Map<String, dynamic> json) =>
    _$TribeModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      createdBy: json['created_by'] as String,
      status: json['status'] as String,
      memberCount: (json['member_count'] as num).toInt(),
      eventsCount: (json['events_count'] as num).toInt(),
      messagesCount: (json['messages_count'] as num).toInt(),
      chiefId: json['chief_id'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      culturalFocus: (json['cultural_focus'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      traditions: (json['traditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => TribeEventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$TribeModelImplToJson(_$TribeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'created_by': instance.createdBy,
      'status': instance.status,
      'member_count': instance.memberCount,
      'events_count': instance.eventsCount,
      'messages_count': instance.messagesCount,
      'chief_id': instance.chiefId,
      'location': instance.location,
      'cultural_focus': instance.culturalFocus,
      'traditions': instance.traditions,
      'events': instance.events,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_$TribeEventModelImpl _$$TribeEventModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TribeEventModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      imageUrl: json['image_url'] as String?,
      createdBy: json['created_by'] as String,
      attendeesCount: (json['attendees_count'] as num).toInt(),
      culturalType: json['cultural_type'] as String?,
      traditions: (json['traditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TribeEventModelImplToJson(
        _$TribeEventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'location': instance.location,
      'image_url': instance.imageUrl,
      'created_by': instance.createdBy,
      'attendees_count': instance.attendeesCount,
      'cultural_type': instance.culturalType,
      'traditions': instance.traditions,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$TribeVoteModelImpl _$$TribeVoteModelImplFromJson(Map<String, dynamic> json) =>
    _$TribeVoteModelImpl(
      id: json['id'] as String,
      tribeId: json['tribe_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdBy: json['created_by'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => VoteOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      endsAt: DateTime.parse(json['ends_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TribeVoteModelImplToJson(
        _$TribeVoteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tribe_id': instance.tribeId,
      'title': instance.title,
      'description': instance.description,
      'created_by': instance.createdBy,
      'options': instance.options,
      'ends_at': instance.endsAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };

_$VoteOptionModelImpl _$$VoteOptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VoteOptionModelImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      votesCount: (json['votes_count'] as num).toInt(),
    );

Map<String, dynamic> _$$VoteOptionModelImplToJson(
        _$VoteOptionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'votes_count': instance.votesCount,
    };
