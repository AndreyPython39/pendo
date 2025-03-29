import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:pendo_mobile/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginWithEmailEvent>(_onLoginWithEmail);
    on<LoginWithPhoneEvent>(_onLoginWithPhone);
    on<RegisterEvent>(_onRegister);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<VerifyPhoneEvent>(_onVerifyPhone);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<RefreshTokenEvent>(_onRefreshToken);
  }

  Future<void> _onLoginWithEmail(
    LoginWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final response = await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(response.user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoginWithPhone(
    LoginWithPhoneEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final response = await _authRepository.login(
        phone: event.phone,
        password: event.password,
      );
      emit(AuthAuthenticated(response.user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final response = await _authRepository.register(
        email: event.email,
        phone: event.phone,
        password: event.password,
        name: event.name,
        age: event.age,
        bio: event.bio,
        interests: event.interests,
      );
      
      if (event.email != null) {
        emit(EmailVerificationRequired());
      } else if (event.phone != null) {
        emit(PhoneVerificationRequired());
      } else {
        emit(RegistrationSuccess(response.user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onVerifyEmail(
    VerifyEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      await _authRepository.verifyEmail(event.code);
      final user = await _authRepository.getCurrentUser();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }

  Future<void> _onVerifyPhone(
    VerifyPhoneEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      await _authRepository.verifyPhone(event.code);
      final user = await _authRepository.getCurrentUser();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      await _authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final isLoggedIn = await _authRepository.isLoggedIn();
      
      if (isLoggedIn) {
        final user = await _authRepository.getCurrentUser();
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRefreshToken(
    RefreshTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Get refresh token from storage
      final response = await _authRepository.refreshToken('refresh_token');
      emit(AuthAuthenticated(response.user));
    } catch (e) {
      emit(TokenRefreshError(e.toString()));
    }
  }
}
