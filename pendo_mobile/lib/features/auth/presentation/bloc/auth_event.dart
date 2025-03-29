import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginWithEmailEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LoginWithPhoneEvent extends AuthEvent {
  final String phone;
  final String password;

  const LoginWithPhoneEvent({
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [phone, password];
}

class RegisterEvent extends AuthEvent {
  final String? email;
  final String? phone;
  final String password;
  final String name;
  final int age;
  final String? bio;
  final List<String> interests;

  const RegisterEvent({
    this.email,
    this.phone,
    required this.password,
    required this.name,
    required this.age,
    this.bio,
    required this.interests,
  });

  @override
  List<Object?> get props => [
        email,
        phone,
        password,
        name,
        age,
        bio,
        interests,
      ];
}

class VerifyEmailEvent extends AuthEvent {
  final String code;

  const VerifyEmailEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class VerifyPhoneEvent extends AuthEvent {
  final String code;

  const VerifyPhoneEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class LogoutEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}

class RefreshTokenEvent extends AuthEvent {}
