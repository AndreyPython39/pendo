import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RequestCodeEvent extends AuthEvent {
  final String email;

  const RequestCodeEvent({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class VerifyCodeEvent extends AuthEvent {
  final String email;
  final String code;

  const VerifyCodeEvent({
    required this.email,
    required this.code,
  });

  @override
  List<Object?> get props => [email, code];
}

class RegisterEvent extends AuthEvent {
  final String? email;
  final String? phone;
  final String name;
  final int age;
  final String? bio;
  final List<String> interests;

  const RegisterEvent({
    this.email,
    this.phone,
    required this.name,
    required this.age,
    this.bio,
    required this.interests,
  });

  @override
  List<Object?> get props => [email, phone, name, age, bio, interests];
}

class LogoutEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}

class RefreshTokenEvent extends AuthEvent {}
