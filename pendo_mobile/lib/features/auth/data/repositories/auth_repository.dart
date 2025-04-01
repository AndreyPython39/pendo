import 'package:pendo_mobile/core/network/dio_client.dart';
import 'package:pendo_mobile/core/services/secure_storage_service.dart';
import 'package:pendo_mobile/core/services/biometric_service.dart';
import 'package:pendo_mobile/core/constants/api_constants.dart';
import 'package:pendo_mobile/features/auth/domain/entities/auth_result.dart';
import 'package:pendo_mobile/features/auth/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final DioClient _dioClient;
  final SecureStorageService _storage;
  final BiometricService _biometric;

  AuthRepository(this._dioClient, this._storage, this._biometric);

  @override
  Future<void> requestCode(String email) async {
    await _dioClient.post(
      ApiConstants.requestCode,
      data: {'email': email},
    );
  }

  @override
  Future<AuthResult> verifyCode(String email, String code) async {
    final response = await _dioClient.post(
      ApiConstants.verifyCode,
      data: {
        'email': email,
        'code': code,
      },
    );

    final result = AuthResult.fromJson(response.data);

    // Save tokens
    await _storage.saveAccessToken(result.accessToken);
    await _storage.saveRefreshToken(result.refreshToken);
    await _storage.saveUserId(result.user.id);

    return result;
  }

  @override
  Future<AuthResult> login(String email, String password) async {
    final response = await _dioClient.post(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    final result = AuthResult.fromJson(response.data);

    // Save tokens
    await _storage.saveAccessToken(result.accessToken);
    await _storage.saveRefreshToken(result.refreshToken);
    await _storage.saveUserId(result.user.id);

    return result;
  }

  @override
  Future<AuthResult> register({
    required String email,
    required String password,
    required String name,
    required DateTime birthDate,
    required String gender,
  }) async {
    final response = await _dioClient.post(
      ApiConstants.register,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'birth_date': birthDate.toIso8601String(),
        'gender': gender,
      },
    );

    final result = AuthResult.fromJson(response.data);

    // Save tokens
    await _storage.saveAccessToken(result.accessToken);
    await _storage.saveRefreshToken(result.refreshToken);
    await _storage.saveUserId(result.user.id);

    return result;
  }

  @override
  Future<void> logout() async {
    try {
      await _dioClient.post(ApiConstants.logout);
    } finally {
      await _storage.clearAuthData();
    }
  }

  @override
  Future<AuthResult> refreshToken() async {
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }

    final response = await _dioClient.post(
      ApiConstants.refreshToken,
      data: {'refresh_token': refreshToken},
    );

    final result = AuthResult.fromJson(response.data);

    // Save new tokens
    await _storage.saveAccessToken(result.accessToken);
    await _storage.saveRefreshToken(result.refreshToken);

    return result;
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _dioClient.post(
      ApiConstants.forgotPassword,
      data: {'email': email},
    );
  }

  @override
  Future<void> resetPassword(String token, String password) async {
    await _dioClient.post(
      ApiConstants.resetPassword,
      data: {
        'token': token,
        'password': password,
      },
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storage.getAccessToken();
    return token != null;
  }

  @override
  Future<bool> authenticateWithBiometrics() async {
    if (!await _biometric.isBiometricAvailable()) {
      return true;
    }

    return await _biometric.authenticate();
  }

  @override
  Future<void> enableBiometrics() async {
    await _biometric.enableBiometric();
  }

  @override
  Future<void> disableBiometrics() async {
    await _biometric.disableBiometric();
  }
}
