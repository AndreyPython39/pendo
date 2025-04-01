class ServerException implements Exception {
  final String message;

  ServerException({this.message = 'Server error occurred'});

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'No internet connection'});

  @override
  String toString() => message;
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException({this.message = 'Connection timed out'});

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({this.message = 'Unauthorized'});

  @override
  String toString() => message;
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException({this.message = 'Bad request'});

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException({this.message = 'Not found'});

  @override
  String toString() => message;
}

class ForbiddenException implements Exception {
  final String message;

  ForbiddenException({this.message = 'Access denied'});

  @override
  String toString() => message;
}

class ConflictException implements Exception {
  final String message;

  ConflictException({this.message = 'Conflict occurred'});

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  final Map<String, dynamic>? errors;

  ValidationException({
    this.message = 'Validation failed',
    this.errors,
  });

  @override
  String toString() => message;
}

class RequestCancelledException implements Exception {
  final String message;

  RequestCancelledException({this.message = 'Request cancelled'});

  @override
  String toString() => message;
}

class UnknownException implements Exception {
  final String message;

  UnknownException({this.message = 'Unknown error occurred'});

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException({this.message = 'Cache error occurred'});

  @override
  String toString() => message;
}
