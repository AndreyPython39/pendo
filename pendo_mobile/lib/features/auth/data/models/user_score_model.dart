import 'package:json_annotation/json_annotation.dart';

part 'user_score_model.g.dart';

@JsonSerializable()
class UserScoreModel {
  final String userId;
  final int score;
  final String level;
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  UserScoreModel({
    required this.userId,
    required this.score,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserScoreModel.fromJson(Map<String, dynamic> json) =>
      _$UserScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserScoreModelToJson(this);
}
