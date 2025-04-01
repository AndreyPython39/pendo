// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserScoreModel _$UserScoreModelFromJson(Map<String, dynamic> json) =>
    UserScoreModel(
      userId: json['userId'] as String,
      score: (json['score'] as num).toInt(),
      level: json['level'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserScoreModelToJson(UserScoreModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'score': instance.score,
      'level': instance.level,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
