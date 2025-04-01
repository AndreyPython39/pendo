import 'package:pendo_mobile/features/auth/data/models/auth_model.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<void> requestCode({
    required String email,
  });

  Future<AuthResponseModel> verifyCode({
    required String email,
    required String code,
  });

  Future<AuthResponseModel> register({
    String? email,
    String? phone,
    required String name,
    required int age,
    String? bio,
    required List<String> interests,
  });

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Future<void> refreshToken();

  Future<void> updateFcmToken(String token);

  Future<void> updateLastActive();
}
