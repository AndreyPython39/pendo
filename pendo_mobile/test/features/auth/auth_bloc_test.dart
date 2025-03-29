import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pendo_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:pendo_mobile/features/auth/data/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(authBloc.state, equals(AuthInitial()));
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login is successful',
      build: () {
        when(mockAuthRepository.login(
          email: 'test@example.com',
          password: 'password',
        )).thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginRequested(
        email: 'test@example.com',
        password: 'password',
      )),
      expect: () => [
        AuthLoading(),
        AuthSuccess(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when login fails',
      build: () {
        when(mockAuthRepository.login(
          email: 'test@example.com',
          password: 'wrong_password',
        )).thenThrow(Exception('Invalid credentials'));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginRequested(
        email: 'test@example.com',
        password: 'wrong_password',
      )),
      expect: () => [
        AuthLoading(),
        AuthFailure(error: 'Invalid credentials'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when registration is successful',
      build: () {
        when(mockAuthRepository.register(
          email: 'test@example.com',
          password: 'password',
          fullName: 'Test User',
        )).thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) => bloc.add(RegisterRequested(
        email: 'test@example.com',
        password: 'password',
        fullName: 'Test User',
      )),
      expect: () => [
        AuthLoading(),
        AuthSuccess(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when logout is successful',
      build: () {
        when(mockAuthRepository.logout())
            .thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) => bloc.add(LogoutRequested()),
      expect: () => [
        AuthLoading(),
        AuthInitial(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when password reset is successful',
      build: () {
        when(mockAuthRepository.resetPassword(
          email: 'test@example.com',
        )).thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) => bloc.add(PasswordResetRequested(
        email: 'test@example.com',
      )),
      expect: () => [
        AuthLoading(),
        AuthSuccess(),
      ],
    );
  });
}
