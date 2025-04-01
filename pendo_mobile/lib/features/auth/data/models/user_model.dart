import 'package:json_annotation/json_annotation.dart';
import 'package:pendo_mobile/features/shared/models/location_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String? email;
  final String? phone;
  final String name;
  final int age;
  final String? bio;
  final List<String> interests;
  final bool isVerified;
  final String? avatarUrl;
  final LocationModel? location;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    this.email,
    this.phone,
    required this.name,
    required this.age,
    this.bio,
    required this.interests,
    required this.isVerified,
    this.avatarUrl,
    this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
