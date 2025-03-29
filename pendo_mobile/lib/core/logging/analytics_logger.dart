import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import '../config/config.dart';

class AnalyticsLogger {
  static final AnalyticsLogger _instance = AnalyticsLogger._internal();
  static AnalyticsLogger get instance => _instance;

  late final FirebaseAnalytics _firebase;
  late final Mixpanel _mixpanel;
  bool _initialized = false;

  AnalyticsLogger._internal();

  Future<void> init() async {
    if (_initialized) return;

    _firebase = FirebaseAnalytics.instance;
    _mixpanel = await Mixpanel.init(
      Config.mixpanelToken,
      optOutTrackingDefault: false,
    );

    _initialized = true;
  }

  void setUserProperties({
    required String userId,
    String? name,
    String? email,
    Map<String, dynamic>? properties,
  }) {
    // Firebase
    _firebase.setUserId(id: userId);
    if (name != null) _firebase.setUserProperty(name: 'name', value: name);
    if (email != null) _firebase.setUserProperty(name: 'email', value: email);
    
    // Mixpanel
    _mixpanel.identify(userId);
    if (properties != null) {
      _mixpanel.getPeople().set(properties);
    }
  }

  void logEvent(
    String name, {
    Map<String, dynamic>? parameters,
    bool firebase = true,
    bool mixpanel = true,
  }) {
    if (firebase) {
      _firebase.logEvent(
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

  void logScreenView(String screenName, {String? screenClass}) {
    _firebase.logScreenView(
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

  void logLogin(String method) {
    logEvent(
      'login',
      parameters: {'method': method},
    );
  }

  void logSignUp(String method) {
    logEvent(
      'sign_up',
      parameters: {'method': method},
    );
  }

  void logMatch(String matchId) {
    logEvent(
      'match',
      parameters: {'match_id': matchId},
    );
  }

  void logLike(String targetUserId) {
    logEvent(
      'like',
      parameters: {'target_user_id': targetUserId},
    );
  }

  void logMessage(String chatId) {
    logEvent(
      'message_sent',
      parameters: {'chat_id': chatId},
    );
  }

  void logStoryView(String storyId) {
    logEvent(
      'story_view',
      parameters: {'story_id': storyId},
    );
  }

  void logTribeAction(String action, String tribeId) {
    logEvent(
      'tribe_action',
      parameters: {
        'action': action,
        'tribe_id': tribeId,
      },
    );
  }

  void logPurchase(
    String productId,
    double amount,
    String currency, {
    String? transactionId,
  }) {
    logEvent(
      'purchase',
      parameters: {
        'product_id': productId,
        'amount': amount,
        'currency': currency,
        'transaction_id': transactionId,
      },
    );
  }

  void logError(String message, {Map<String, dynamic>? details}) {
    logEvent(
      'error',
      parameters: {
        'message': message,
        'details': details,
      },
      mixpanel: false, // Don't send errors to Mixpanel
    );
  }

  void logPerformanceMetric(String name, int valueMs) {
    logEvent(
      'performance',
      parameters: {
        'metric': name,
        'value_ms': valueMs,
      },
    );
  }

  void setUserPreferences(Map<String, dynamic> preferences) {
    _mixpanel.getPeople().set({
      'preferences': preferences,
    });
  }

  void incrementUserProperty(String property, {num value = 1}) {
    _mixpanel.getPeople().increment(property, value);
  }

  Future<void> optOut() async {
    await _mixpanel.optOutTracking();
  }

  Future<void> optIn() async {
    await _mixpanel.optInTracking();
  }
}
