import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pendo_mobile/core/constants/api_constants.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  bool _isRefreshing = false;

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header for auth endpoints
    if (_isAuthEndpoint(options.path)) {
      return handler.next(options);
    }

    final token = await _storage.read(key: 'access_token');
    if (token != null) {
      options.headers[ApiConstants.authorization] =
          '${ApiConstants.bearer}$token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      try {
        final refreshToken = await _storage.read(key: 'refresh_token');
        if (refreshToken == null) {
          return handler.next(err);
        }

        // Create new Dio instance to avoid interceptors loop
        final dio = Dio(BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          headers: {
            ApiConstants.contentType: ApiConstants.applicationJson,
            ApiConstants.accept: ApiConstants.applicationJson,
          },
        ));

        final response = await dio.post(
          ApiConstants.refreshToken,
          data: {
            'refresh_token': refreshToken,
          },
        );

        // Save new tokens
        await _storage.write(
          key: 'access_token',
          value: response.data['access_token'],
        );
        await _storage.write(
          key: 'refresh_token',
          value: response.data['refresh_token'],
        );

        // Retry original request
        final options = err.requestOptions;
        options.headers[ApiConstants.authorization] =
            '${ApiConstants.bearer}${response.data['access_token']}';

        try {
          final response = await dio.fetch(options);
          return handler.resolve(response);
        } on DioException catch (e) {
          return handler.next(e);
        }
      } catch (e) {
        // Clear tokens on refresh error
        await _storage.delete(key: 'access_token');
        await _storage.delete(key: 'refresh_token');
        return handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    }

    return handler.next(err);
  }

  bool _isAuthEndpoint(String path) {
    return path.contains('/auth/') &&
        !path.contains('/refresh') &&
        !path.contains('/logout');
  }
}
