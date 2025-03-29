import 'package:json_annotation/json_annotation.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final UserModel user;
  final DateTime expiresAt;

  const AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.expiresAt,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}

@JsonSerializable()
class LoginRequestModel {
  final String? email;
  final String? phone;
  final String password;

  const LoginRequestModel({
    this.email,
    this.phone,
    required this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}

@JsonSerializable()
class RegisterRequestModel {
  final String? email;
  final String? phone;
  final String password;
  final String name;
  final int age;
  final String? bio;
  final List<String> interests;

  const RegisterRequestModel({
    this.email,
    this.phone,
    required this.password,
    required this.name,
    required this.age,
    this.bio,
    required this.interests,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}

@JsonSerializable()
class VerificationRequestModel {
  final String code;
  final String type; // email or phone

  const VerificationRequestModel({
    required this.code,
    required this.type,
  });

  factory VerificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerificationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationRequestModelToJson(this);
}

@JsonSerializable()
class RefreshTokenRequestModel {
  final String refreshToken;

  const RefreshTokenRequestModel({
    required this.refreshToken,
  });

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestModelToJson(this);
}
