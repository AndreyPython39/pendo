import 'package:json_annotation/json_annotation.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  @JsonKey(name: 'access_token')
  final String accessToken;
  
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  
  @JsonKey(name: 'token_type')
  final String tokenType;
  
  final UserModel user;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.user,
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

  LoginRequestModel({
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

  RegisterRequestModel({
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
