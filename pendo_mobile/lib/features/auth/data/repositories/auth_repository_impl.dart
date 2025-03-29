import 'package:dio/dio.dart';
import 'package:pendo_mobile/core/constants/api_constants.dart';
import 'package:pendo_mobile/features/auth/data/models/auth_model.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';
import 'package:pendo_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._dio, this._prefs);

  @override
  Future<AuthResponseModel> login({
    String? email,
    String? phone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: LoginRequestModel(
          email: email,
          phone: phone,
          password: password,
        ).toJson(),
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      await _saveAuthData(authResponse);
      return authResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthResponseModel> register({
    String? email,
    String? phone,
    required String password,
    required String name,
    required int age,
    String? bio,
    required List<String> interests,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: RegisterRequestModel(
          email: email,
          phone: phone,
          password: password,
          name: name,
          age: age,
          bio: bio,
          interests: interests,
        ).toJson(),
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      await _saveAuthData(authResponse);
      return authResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> verifyEmail(String code) async {
    try {
      await _dio.post(
        ApiConstants.verifyEmail,
        data: VerificationRequestModel(
          code: code,
          type: 'email',
        ).toJson(),
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> verifyPhone(String code) async {
    try {
      await _dio.post(
        ApiConstants.verifyPhone,
        data: VerificationRequestModel(
          code: code,
          type: 'phone',
        ).toJson(),
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthResponseModel> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        ApiConstants.refreshToken,
        data: RefreshTokenRequestModel(
          refreshToken: refreshToken,
        ).toJson(),
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      await _saveAuthData(authResponse);
      return authResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
      await _clearAuthData();
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _dio.post(
        ApiConstants.forgotPassword,
        data: {'email': email},
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _dio.post(
        ApiConstants.resetPassword,
        data: {
          'token': token,
          'password': newPassword,
        },
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiConstants.profile);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> updateFcmToken(String token) async {
    try {
      await _dio.post(
        '${ApiConstants.profile}/fcm-token',
        data: {'token': token},
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = _prefs.getString('access_token');
    return token != null;
  }

  Future<void> _saveAuthData(AuthResponseModel auth) async {
    await _prefs.setString('access_token', auth.accessToken);
    await _prefs.setString('refresh_token', auth.refreshToken);
    await _prefs.setInt('user_id', auth.user.id);
  }

  Future<void> _clearAuthData() async {
    await _prefs.remove('access_token');
    await _prefs.remove('refresh_token');
    await _prefs.remove('user_id');
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return Exception('Connection timeout');
      }

      if (error.response?.statusCode == 401) {
        return Exception('Invalid credentials');
      }

      if (error.response?.data != null &&
          error.response?.data['message'] != null) {
        return Exception(error.response?.data['message']);
      }
    }

    return Exception('Something went wrong');
  }
}
