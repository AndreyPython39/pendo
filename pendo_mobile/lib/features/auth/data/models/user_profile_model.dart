import 'package:json_annotation/json_annotation.dart';
import 'package:pendo_mobile/features/shared/models/location_model.dart';
import 'package:pendo_mobile/features/auth/data/models/cultural_preferences_model.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  final String userId;
  final String name;
  final int age;
  final String gender;
  final String lookingFor;
  final String? bio;
  final List<String>? interests;
  final String? temperament;
  
  @JsonKey(name: 'extra_data')
  final Map<String, dynamic>? extraData;
  
  @JsonKey(name: 'profile_photos')
  final List<String>? profilePhotos;
  
  @JsonKey(name: 'pendo_score')
  final int? pendoScore;
  
  @JsonKey(name: 'is_verified')
  final bool? isVerified;
  
  @JsonKey(name: 'is_premium')
  final bool? isPremium;
  
  final LocationModel? location;
  final double? distance;
  
  @JsonKey(name: 'last_active')
  final DateTime? lastActive;
  
  @JsonKey(name: 'cultural_preferences')
  final CulturalPreferencesModel? culturalPreferences;

  UserProfileModel({
    required this.userId,
    required this.name,
    required this.age,
    required this.gender,
    required this.lookingFor,
    this.bio,
    this.interests,
    this.temperament,
    this.extraData,
    this.profilePhotos,
    this.pendoScore,
    this.isVerified,
    this.isPremium,
    this.location,
    this.distance,
    this.lastActive,
    this.culturalPreferences,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
