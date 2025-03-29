import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../config/config.dart';

class Analytics {
  static final Analytics _instance = Analytics._internal();
  static Analytics get instance => _instance;

  late final FirebaseAnalytics _firebase;
  late final Mixpanel _mixpanel;
  bool _initialized = false;

  Analytics._internal();

  Future<void> init() async {
    if (_initialized) return;

    _firebase = FirebaseAnalytics.instance;
    _mixpanel = await Mixpanel.init(
      Config.mixpanelToken,
      optOutTrackingDefault: false,
    );

    _initialized = true;
  }

  // User Properties
  Future<void> setUserProperties({
    required String userId,
    String? name,
    String? email,
    Map<String, dynamic>? properties,
  }) async {
    // Firebase
    await _firebase.setUserId(id: userId);
    if (name != null) {
      await _firebase.setUserProperty(name: 'name', value: name);
    }
    if (email != null) {
      await _firebase.setUserProperty(name: 'email', value: email);
    }

    // Mixpanel
    _mixpanel.identify(userId);
    if (properties != null) {
      _mixpanel.getPeople().set(properties);
    }

    // Sentry
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(
        id: userId,
        email: email,
        username: name,
      ));
    });
  }

  // Event Tracking
  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
    bool firebase = true,
    bool mixpanel = true,
  }) async {
    if (firebase) {
      await _firebase.logEvent(
        name: name,
        parameters: parameters,
      );
    }

    if (mixpanel) {
      _mixpanel.track(
        name,
        properties: parameters,
      );
    }
  }

  // Screen Views
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _firebase.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );

    _mixpanel.track(
      'Screen View',
      properties: {
        'screen_name': screenName,
        'screen_class': screenClass,
      },
    );
  }

  // User Actions
  Future<void> logLogin({required String method}) async {
    await logEvent(
      name: 'login',
      parameters: {'method': method},
    );
  }

  Future<void> logSignUp({required String method}) async {
    await logEvent(
      name: 'sign_up',
      parameters: {'method': method},
    );
  }

  Future<void> logMatch({required String matchId}) async {
    await logEvent(
      name: 'match',
      parameters: {'match_id': matchId},
    );
  }

  Future<void> logLike({required String targetUserId}) async {
    await logEvent(
      name: 'like',
      parameters: {'target_user_id': targetUserId},
    );
  }

  Future<void> logMessage({required String chatId}) async {
    await logEvent(
      name: 'message_sent',
      parameters: {'chat_id': chatId},
    );
  }

  Future<void> logStoryView({required String storyId}) async {
    await logEvent(
      name: 'story_view',
      parameters: {'story_id': storyId},
    );
  }

  // Premium Features
  Future<void> logPurchase({
    required String productId,
    required double amount,
    required String currency,
    String? transactionId,
  }) async {
    await logEvent(
      name: 'purchase',
      parameters: {
        'product_id': productId,
        'amount': amount,
        'currency': currency,
        'transaction_id': transactionId,
      },
    );
  }

  // Error Tracking
  Future<void> logError({
    required String message,
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? details,
  }) async {
    await logEvent(
      name: 'error',
      parameters: {
        'message': message,
        'error': error?.toString(),
        'details': details,
      },
      mixpanel: false,
    );

    await Sentry.captureException(
      error ?? message,
      stackTrace: stackTrace,
    );
  }

  // Performance Monitoring
  Future<void> logPerformanceMetric({
    required String name,
    required int valueMs,
  }) async {
    await logEvent(
      name: 'performance',
      parameters: {
        'metric': name,
        'value_ms': valueMs,
      },
    );
  }

  // User Preferences
  Future<void> setUserPreferences(Map<String, dynamic> preferences) async {
    _mixpanel.getPeople().set({
      'preferences': preferences,
    });
  }

  // Engagement Metrics
  Future<void> incrementUserProperty({
    required String property,
    num value = 1,
  }) async {
    _mixpanel.getPeople().increment(property, value);
  }

  // Opt Out
  Future<void> optOut() async {
    await _mixpanel.optOutTracking();
  }

  Future<void> optIn() async {
    await _mixpanel.optInTracking();
  }
}
