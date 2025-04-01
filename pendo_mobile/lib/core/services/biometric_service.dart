import 'package:local_auth/local_auth.dart';
import 'package:pendo_mobile/core/services/secure_storage_service.dart';

class BiometricService {
  final LocalAuthentication _localAuth;
  final SecureStorageService _storage;

  BiometricService(this._localAuth, this._storage);

  Future<bool> isBiometricAvailable() async {
    try {
      // Check if device supports biometric authentication
      final canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

      return canAuthenticate;
    } catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  Future<bool> authenticate() async {
    try {
      final isEnabled = await _storage.isBiometricEnabled();
      if (!isEnabled) return true;

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      return authenticated;
    } catch (e) {
      return false;
    }
  }

  Future<void> enableBiometric() async {
    final canAuthenticate = await isBiometricAvailable();
    if (!canAuthenticate) {
      throw Exception('Biometric authentication is not available');
    }

    final authenticated = await authenticate();
    if (!authenticated) {
      throw Exception('Biometric authentication failed');
    }

    await _storage.setBiometricEnabled(true);
  }

  Future<void> disableBiometric() async {
    final authenticated = await authenticate();
    if (!authenticated) {
      throw Exception('Biometric authentication failed');
    }

    await _storage.setBiometricEnabled(false);
  }
}
