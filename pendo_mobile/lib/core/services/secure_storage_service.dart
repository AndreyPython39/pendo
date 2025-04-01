import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  // Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String fcmTokenKey = 'fcm_token';
  static const String biometricEnabledKey = 'biometric_enabled';

  // Token Management
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: accessTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: refreshTokenKey);
  }

  // User Management
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: userIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: userIdKey);
  }

  // FCM Token Management
  Future<void> saveFcmToken(String token) async {
    await _storage.write(key: fcmTokenKey, value: token);
  }

  Future<String?> getFcmToken() async {
    return await _storage.read(key: fcmTokenKey);
  }

  // Biometric Authentication
  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(
      key: biometricEnabledKey,
      value: enabled.toString(),
    );
  }

  Future<bool> isBiometricEnabled() async {
    final value = await _storage.read(key: biometricEnabledKey);
    return value == 'true';
  }

  // Clear All Data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Clear Auth Data
  Future<void> clearAuthData() async {
    await _storage.delete(key: accessTokenKey);
    await _storage.delete(key: refreshTokenKey);
    await _storage.delete(key: userIdKey);
  }
}
