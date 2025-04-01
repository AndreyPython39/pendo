// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultural_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CulturalPreferencesModel _$CulturalPreferencesModelFromJson(
        Map<String, dynamic> json) =>
    CulturalPreferencesModel(
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      traditions: (json['traditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      music:
          (json['music'] as List<dynamic>?)?.map((e) => e as String).toList(),
      food: (json['food'] as List<dynamic>?)?.map((e) => e as String).toList(),
      festivals: (json['festivals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      culturalValues: (json['cultural_values'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CulturalPreferencesModelToJson(
        CulturalPreferencesModel instance) =>
    <String, dynamic>{
      'languages': instance.languages,
      'traditions': instance.traditions,
      'music': instance.music,
      'food': instance.food,
      'festivals': instance.festivals,
      'cultural_values': instance.culturalValues,
    };
