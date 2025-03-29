import 'package:json_annotation/json_annotation.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';

part 'tribe_model.g.dart';

@JsonSerializable()
class TribeModel {
  final String id;
  final String name;
  final String description;
  final String avatar;
  final String coverImage;
  final String status; // active, pending, archived
  final UserModel chief;
  final List<UserModel> moderators;
  final List<UserModel> members;
  final Map<String, dynamic> settings;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TribeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.avatar,
    required this.coverImage,
    required this.status,
    required this.chief,
    required this.moderators,
    required this.members,
    required this.settings,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TribeModel.fromJson(Map<String, dynamic> json) =>
      _$TribeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TribeModelToJson(this);
}

@JsonSerializable()
class TribeEventModel {
  final String id;
  final String tribeId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final double? latitude;
  final double? longitude;
  final List<UserModel> attendees;
  final Map<String, dynamic>? metadata;

  const TribeEventModel({
    required this.id,
    required this.tribeId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    this.latitude,
    this.longitude,
    required this.attendees,
    this.metadata,
  });

  factory TribeEventModel.fromJson(Map<String, dynamic> json) =>
      _$TribeEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$TribeEventModelToJson(this);
}

@JsonSerializable()
class TribeVoteModel {
  final String id;
  final String tribeId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> options;
  final Map<String, List<String>> votes; // option -> [userId]
  final bool isActive;

  const TribeVoteModel({
    required this.id,
    required this.tribeId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.options,
    required this.votes,
    required this.isActive,
  });

  factory TribeVoteModel.fromJson(Map<String, dynamic> json) =>
      _$TribeVoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$TribeVoteModelToJson(this);
}
