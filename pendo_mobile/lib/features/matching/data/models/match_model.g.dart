// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => MatchModel(
      id: json['id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      isSuperLike: json['isSuperLike'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool,
      lastMessage: json['lastMessage'] as String?,
      lastMessageAt: json['lastMessageAt'] == null
          ? null
          : DateTime.parse(json['lastMessageAt'] as String),
    );

Map<String, dynamic> _$MatchModelToJson(MatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'isSuperLike': instance.isSuperLike,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'lastMessage': instance.lastMessage,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
    };

SwipeActionModel _$SwipeActionModelFromJson(Map<String, dynamic> json) =>
    SwipeActionModel(
      userId: json['userId'] as String,
      action: json['action'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$SwipeActionModelToJson(SwipeActionModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'action': instance.action,
      'timestamp': instance.timestamp.toIso8601String(),
    };
