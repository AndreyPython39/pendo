// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      lookingFor: json['lookingFor'] as String,
      bio: json['bio'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      temperament: json['temperament'] as String?,
      extraData: json['extra_data'] as Map<String, dynamic>?,
      profilePhotos: (json['profile_photos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      pendoScore: (json['pendo_score'] as num?)?.toInt(),
      isVerified: json['is_verified'] as bool?,
      isPremium: json['is_premium'] as bool?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toDouble(),
      lastActive: json['last_active'] == null
          ? null
          : DateTime.parse(json['last_active'] as String),
      culturalPreferences: json['cultural_preferences'] == null
          ? null
          : CulturalPreferencesModel.fromJson(
              json['cultural_preferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'lookingFor': instance.lookingFor,
      'bio': instance.bio,
      'interests': instance.interests,
      'temperament': instance.temperament,
      'extra_data': instance.extraData,
      'profile_photos': instance.profilePhotos,
      'pendo_score': instance.pendoScore,
      'is_verified': instance.isVerified,
      'is_premium': instance.isPremium,
      'location': instance.location,
      'distance': instance.distance,
      'last_active': instance.lastActive?.toIso8601String(),
      'cultural_preferences': instance.culturalPreferences,
    };
