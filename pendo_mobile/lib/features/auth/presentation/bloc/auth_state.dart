import 'package:equatable/equatable.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class EmailVerificationRequired extends AuthState {}

class PhoneVerificationRequired extends AuthState {}

class VerificationSuccess extends AuthState {}

class VerificationError extends AuthState {
  final String message;

  const VerificationError(this.message);

  @override
  List<Object?> get props => [message];
}

class RegistrationSuccess extends AuthState {
  final UserModel user;

  const RegistrationSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class TokenRefreshError extends AuthState {
  final String message;

  const TokenRefreshError(this.message);

  @override
  List<Object?> get props => [message];
}
