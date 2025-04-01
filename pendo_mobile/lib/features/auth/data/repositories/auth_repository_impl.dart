import 'package:dio/dio.dart';
import 'package:pendo_mobile/core/constants/api_constants.dart';
import 'package:pendo_mobile/features/auth/data/models/auth_model.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';
import 'package:pendo_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._dio, this._prefs);

  @override
  Future<void> requestCode({
    required String email,
  }) async {
    try {
      await _dio.post(
        ApiConstants.requestCode,
        data: {
          'email': email,
        },
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthResponseModel> verifyCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.verifyCode,
        data: {
          'email': email,
          'code': code,
        },
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      
      // Save tokens
      await _prefs.setString('access_token', authResponse.accessToken);
      await _prefs.setString('refresh_token', authResponse.refreshToken);
      
      // Save user
      await _prefs.setString('user', response.data['user'].toString());

      return authResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthResponseModel> register({
    String? email,
    String? phone,
    required String name,
    required int age,
    String? bio,
    required List<String> interests,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: {
          if (email != null) 'email': email,
          if (phone != null) 'phone': phone,
          'name': name,
          'age': age,
          if (bio != null) 'bio': bio,
          'interests': interests,
        },
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      
      // Save tokens
      await _prefs.setString('access_token', authResponse.accessToken);
      await _prefs.setString('refresh_token', authResponse.refreshToken);
      
      // Save user
      await _prefs.setString('user', response.data['user'].toString());

      return authResponse;
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
      await _clearStorage();
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final userJson = _prefs.getString('user');
      if (userJson != null) {
        return UserModel.fromJson(userJson as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> refreshToken() async {
    try {
      final refreshToken = _prefs.getString('refresh_token');
      if (refreshToken == null) {
        throw Exception('No refresh token found');
      }

      final response = await _dio.post(
        ApiConstants.refreshToken,
        data: {
          'refresh_token': refreshToken,
        },
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      
      // Save new tokens
      await _prefs.setString('access_token', authResponse.accessToken);
      await _prefs.setString('refresh_token', authResponse.refreshToken);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> updateFcmToken(String token) async {
    try {
      await _dio.post(
        ApiConstants.updateFcmToken,
        data: {
          'token': token,
        },
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> updateLastActive() async {
    try {
      await _dio.post(ApiConstants.updateLastActive);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> _clearStorage() async {
    await _prefs.remove('access_token');
    await _prefs.remove('refresh_token');
    await _prefs.remove('user');
  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response?.data != null &&
          error.response?.data['message'] != null) {
        return error.response?.data['message'];
      }
      return error.message ?? 'Something went wrong';
    }
    return error.toString();
  }
}
