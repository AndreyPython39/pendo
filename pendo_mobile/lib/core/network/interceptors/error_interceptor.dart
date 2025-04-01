import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        err.error = 'Connection timed out';
        break;
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            err.error = 'Bad request';
            break;
          case 401:
            err.error = 'Unauthorized';
            break;
          case 403:
            err.error = 'Access denied';
            break;
          case 404:
            err.error = 'Not found';
            break;
          case 409:
            err.error = 'Conflict occurred';
            break;
          case 422:
            err.error = 'Validation failed';
            break;
          case 500:
            err.error = 'Server error';
            break;
          default:
            err.error = 'Something went wrong';
            break;
        }
        break;
      case DioExceptionType.cancel:
        err.error = 'Request cancelled';
        break;
      case DioExceptionType.unknown:
        err.error = 'No internet connection';
        break;
      default:
        err.error = 'Something went wrong';
        break;
    }

    return handler.next(err);
  }
}
