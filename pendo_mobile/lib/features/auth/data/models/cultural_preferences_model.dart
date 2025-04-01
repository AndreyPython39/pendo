import 'package:json_annotation/json_annotation.dart';

part 'cultural_preferences_model.g.dart';

@JsonSerializable()
class CulturalPreferencesModel {
  final List<String>? languages;
  final List<String>? traditions;
  final List<String>? music;
  final List<String>? food;
  final List<String>? festivals;
  
  @JsonKey(name: 'cultural_values')
  final List<String>? culturalValues;

  CulturalPreferencesModel({
    this.languages,
    this.traditions,
    this.music,
    this.food,
    this.festivals,
    this.culturalValues,
  });

  factory CulturalPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$CulturalPreferencesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CulturalPreferencesModelToJson(this);
}
