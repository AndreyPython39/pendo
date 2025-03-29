import 'package:pendo_mobile/features/auth/data/models/auth_model.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login({
    String? email,
    String? phone,
    required String password,
  });

  Future<AuthResponseModel> register({
    String? email,
    String? phone,
    required String password,
    required String name,
    required int age,
    String? bio,
    required List<String> interests,
  });

  Future<void> verifyEmail(String code);

  Future<void> verifyPhone(String code);

  Future<AuthResponseModel> refreshToken(String refreshToken);

  Future<void> logout();

  Future<void> forgotPassword(String email);

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<UserModel> getCurrentUser();

  Future<void> updateFcmToken(String token);

  Future<bool> isLoggedIn();
}
