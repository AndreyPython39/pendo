// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tribe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TribeModel _$TribeModelFromJson(Map<String, dynamic> json) => TribeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      avatar: json['avatar'] as String,
      coverImage: json['coverImage'] as String,
      status: json['status'] as String,
      chief: UserModel.fromJson(json['chief'] as Map<String, dynamic>),
      moderators: (json['moderators'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      members: (json['members'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      settings: json['settings'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TribeModelToJson(TribeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'avatar': instance.avatar,
      'coverImage': instance.coverImage,
      'status': instance.status,
      'chief': instance.chief,
      'moderators': instance.moderators,
      'members': instance.members,
      'settings': instance.settings,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

TribeEventModel _$TribeEventModelFromJson(Map<String, dynamic> json) =>
    TribeEventModel(
      id: json['id'] as String,
      tribeId: json['tribeId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      attendees: (json['attendees'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$TribeEventModelToJson(TribeEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tribeId': instance.tribeId,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'attendees': instance.attendees,
      'metadata': instance.metadata,
    };

TribeVoteModel _$TribeVoteModelFromJson(Map<String, dynamic> json) =>
    TribeVoteModel(
      id: json['id'] as String,
      tribeId: json['tribeId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      votes: (json['votes'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$TribeVoteModelToJson(TribeVoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tribeId': instance.tribeId,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'options': instance.options,
      'votes': instance.votes,
      'isActive': instance.isActive,
    };
