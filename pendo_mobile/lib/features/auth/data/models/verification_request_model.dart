import 'package:json_annotation/json_annotation.dart';

part 'verification_request_model.g.dart';

@JsonSerializable()
class VerificationRequestModel {
  final String code;
  final String type; // email or phone

  VerificationRequestModel({
    required this.code,
    required this.type,
  });

  factory VerificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerificationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationRequestModelToJson(this);
}
