import 'package:pendo_mobile/features/auth/data/models/user_model.dart';
import 'package:pendo_mobile/features/matching/data/models/match_model.dart';

abstract class MatchingRepository {
  Future<List<UserModel>> getProfiles({
    double? latitude,
    double? longitude,
    double? maxDistance,
    Map<String, dynamic>? filters,
  });

  Future<void> swipe({
    required String userId,
    required String action,
  });

  Future<List<MatchModel>> getMatches({
    int? page,
    int? limit,
  });

  Future<void> unmatch(String matchId);

  Future<void> reportUser({
    required String userId,
    required String reason,
    String? description,
  });

  Future<void> blockUser(String userId);

  Future<void> unblockUser(String userId);

  Future<List<String>> getBlockedUsers();

  Future<void> boostProfile({
    required int duration,
    required String paymentId,
  });

  Future<void> rewind();

  Future<void> superLike(String userId);

  Future<Map<String, int>> getRemainingActions();
}
