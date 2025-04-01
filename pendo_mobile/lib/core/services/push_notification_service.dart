import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pendo_mobile/core/services/secure_storage_service.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final SecureStorageService _storage;

  // Stream controllers
  final _messageStreamController = StreamController<RemoteMessage>.broadcast();
  Stream<RemoteMessage> get messages => _messageStreamController.stream;

  PushNotificationService(
    this._fcm,
    this._flutterLocalNotificationsPlugin,
    this._storage,
  );

  Future<void> initialize() async {
    // Request permission
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Configure FCM
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessageStatic);

    // Get FCM token
    final token = await _fcm.getToken();
    if (token != null) {
      await _storage.saveFcmToken(token);
    }

    // Listen for token refresh
    _fcm.onTokenRefresh.listen((token) async {
      await _storage.saveFcmToken(token);
      // TODO: Send new token to server
    });

    // Initialize local notifications
    await _initializeLocalNotifications();
  }

  Future<void> _initializeLocalNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null) {
          final data = json.decode(payload);
          // TODO: Handle notification tap
        }
      },
    );
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    _messageStreamController.add(message);

    // Show local notification
    final notification = message.notification;
    final android = message.notification?.android;
    final data = message.data;

    if (notification != null) {
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'This channel is used for important notifications',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker',
            color: const Color(0xFF2196F3),
            styleInformation: android?.imageUrl != null
                ? BigPictureStyleInformation(
                    FilePathAndroidBitmap(android!.imageUrl!),
                    hideExpandedLargeIcon: true,
                  )
                : null,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: json.encode(data),
      );
    }
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // Handle background message when app is opened from notification
    _messageStreamController.add(message);
    // TODO: Navigate to appropriate screen based on message data
  }

  static Future<void> _handleBackgroundMessageStatic(
    RemoteMessage message,
  ) async {
    // Handle background message when app is terminated
    // This method must be static and can't access instance variables
    print('Handling background message: ${message.messageId}');
  }

  Future<void> subscribeToTopic(String topic) async {
    await _fcm.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _fcm.unsubscribeFromTopic(topic);
  }

  void dispose() {
    _messageStreamController.close();
  }
}
