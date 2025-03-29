import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppLogger {
  static final _logger = Logger('PendoApp');
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;
    
    Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
    
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        developer.log(
          record.message,
          time: record.time,
          sequenceNumber: record.sequenceNumber,
          level: record.level.value,
          name: record.loggerName,
          zone: record.zone,
          error: record.error,
          stackTrace: record.stackTrace,
        );
      } else {
        // In production, send to Sentry
        if (record.level >= Level.WARNING) {
          Sentry.addBreadcrumb(
            Breadcrumb(
              category: record.loggerName,
              message: record.message,
              level: _getSentryLevel(record.level),
              timestamp: record.time,
            ),
          );

          if (record.error != null) {
            Sentry.captureException(
              record.error,
              stackTrace: record.stackTrace,
            );
          }
        }
      }
    });

    _initialized = true;
  }

  static SentryLevel _getSentryLevel(Level level) {
    if (level >= Level.SEVERE) return SentryLevel.error;
    if (level >= Level.WARNING) return SentryLevel.warning;
    if (level >= Level.INFO) return SentryLevel.info;
    return SentryLevel.debug;
  }

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.fine(message, error, stackTrace);
  }

  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.info(message, error, stackTrace);
  }

  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  static void logUserAction(String action, Map<String, dynamic> data) {
    _logger.info('UserAction: $action', null, null, data);
  }

  static void logNetworkCall(String url, String method, int statusCode, int duration) {
    _logger.fine(
      'NetworkCall: $method $url',
      null,
      null,
      {
        'statusCode': statusCode,
        'duration': duration,
      },
    );
  }

  static void logError(String message, Object error, StackTrace stackTrace) {
    _logger.severe(message, error, stackTrace);
  }

  static void logLifecycleEvent(String event) {
    _logger.info('Lifecycle: $event');
  }

  static void logNavigationEvent(String routeName, Map<String, dynamic>? params) {
    _logger.info(
      'Navigation: $routeName',
      null,
      null,
      {'params': params},
    );
  }

  static void logStateChange(String bloc, String event, String state) {
    _logger.fine(
      'StateChange: $bloc',
      null,
      null,
      {
        'event': event,
        'state': state,
      },
    );
  }
}
