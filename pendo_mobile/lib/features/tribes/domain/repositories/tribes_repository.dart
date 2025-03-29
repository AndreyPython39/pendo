import 'package:pendo_mobile/features/tribes/data/models/tribe_model.dart';

abstract class TribesRepository {
  Future<List<TribeModel>> getTribes({
    int? page,
    int? limit,
    Map<String, dynamic>? filters,
  });

  Future<TribeModel> createTribe({
    required String name,
    required String description,
    required String avatar,
    required String coverImage,
    required Map<String, dynamic> settings,
  });

  Future<void> updateTribe({
    required String tribeId,
    String? name,
    String? description,
    String? avatar,
    String? coverImage,
    Map<String, dynamic>? settings,
  });

  Future<void> deleteTribe(String tribeId);

  Future<void> joinTribe(String tribeId);

  Future<void> leaveTribe(String tribeId);

  Future<void> addModerator({
    required String tribeId,
    required String userId,
  });

  Future<void> removeModerator({
    required String tribeId,
    required String userId,
  });

  Future<void> kickMember({
    required String tribeId,
    required String userId,
  });

  Future<TribeEventModel> createEvent({
    required String tribeId,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    required String location,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? metadata,
  });

  Future<List<TribeEventModel>> getEvents({
    required String tribeId,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<void> joinEvent({
    required String tribeId,
    required String eventId,
  });

  Future<void> leaveEvent({
    required String tribeId,
    required String eventId,
  });

  Future<TribeVoteModel> createVote({
    required String tribeId,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    required List<String> options,
  });

  Future<void> castVote({
    required String tribeId,
    required String voteId,
    required String option,
  });

  Future<List<TribeVoteModel>> getActiveVotes(String tribeId);

  Future<Map<String, dynamic>> getTribeStats(String tribeId);

  Stream<Map<String, dynamic>> onTribeUpdated();

  Stream<TribeEventModel> onEventCreated();

  Stream<TribeVoteModel> onVoteCreated();
}
