import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required DateTime birthdate,
    required String gender,
    required String lookingFor,
    String? email,
    String? phone,
    String? bio,
    List<String>? interests,
    String? temperament, // MBTI
    @JsonKey(name: 'extra_data') Map<String, dynamic>? extraData,
    @JsonKey(name: 'pendo_score') int? pendoScore,
    @JsonKey(name: 'is_verified') bool? isVerified,
    @JsonKey(name: 'is_premium') bool? isPremium,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'current_tribe_id') String? currentTribeId,
    @JsonKey(name: 'profile_photos') List<String>? profilePhotos,
    @JsonKey(name: 'location') LocationModel? location,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'last_active') DateTime? lastActive,
    @JsonKey(name: 'gifts_sent') List<GiftTransactionModel>? giftsSent,
    @JsonKey(name: 'gifts_received') List<GiftTransactionModel>? giftsReceived,
    @JsonKey(name: 'streams') List<LiveStreamModel>? streams,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    required double latitude,
    required double longitude,
    String? city,
    String? country,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}

@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required String userId,
    required String name,
    required int age,
    required String gender,
    required String lookingFor,
    String? bio,
    List<String>? interests,
    String? temperament,
    @JsonKey(name: 'extra_data') Map<String, dynamic>? extraData,
    @JsonKey(name: 'profile_photos') List<String>? profilePhotos,
    @JsonKey(name: 'pendo_score') int? pendoScore,
    @JsonKey(name: 'is_verified') bool? isVerified,
    @JsonKey(name: 'is_premium') bool? isPremium,
    LocationModel? location,
    double? distance,
    @JsonKey(name: 'last_active') DateTime? lastActive,
    @JsonKey(name: 'cultural_preferences') CulturalPreferencesModel? culturalPreferences,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}

@freezed
class CulturalPreferencesModel with _$CulturalPreferencesModel {
  const factory CulturalPreferencesModel({
    List<String>? languages,
    List<String>? traditions,
    List<String>? music,
    List<String>? food,
    List<String>? festivals,
    @JsonKey(name: 'cultural_values') List<String>? culturalValues,
  }) = _CulturalPreferencesModel;

  factory CulturalPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$CulturalPreferencesModelFromJson(json);
}

@freezed
class UserScoreModel with _$UserScoreModel {
  const factory UserScoreModel({
    required String userId,
    required int score,
    required String level,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _UserScoreModel;

  factory UserScoreModel.fromJson(Map<String, dynamic> json) =>
      _$UserScoreModelFromJson(json);
}
