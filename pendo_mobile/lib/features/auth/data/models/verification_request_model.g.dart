// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationRequestModel _$VerificationRequestModelFromJson(
        Map<String, dynamic> json) =>
    VerificationRequestModel(
      code: json['code'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$VerificationRequestModelToJson(
        VerificationRequestModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'type': instance.type,
    };
