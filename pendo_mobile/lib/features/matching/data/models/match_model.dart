import 'package:json_annotation/json_annotation.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';

part 'match_model.g.dart';

@JsonSerializable()
class MatchModel {
  final String id;
  final UserModel user;
  final bool isSuperLike;
  final DateTime createdAt;
  final bool isRead;
  final String? lastMessage;
  final DateTime? lastMessageAt;

  const MatchModel({
    required this.id,
    required this.user,
    required this.isSuperLike,
    required this.createdAt,
    required this.isRead,
    this.lastMessage,
    this.lastMessageAt,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchModelToJson(this);
}

@JsonSerializable()
class SwipeActionModel {
  final String userId;
  final String action; // like, pass, superLike
  final DateTime timestamp;

  const SwipeActionModel({
    required this.userId,
    required this.action,
    required this.timestamp,
  });

  factory SwipeActionModel.fromJson(Map<String, dynamic> json) =>
      _$SwipeActionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SwipeActionModelToJson(this);
}
