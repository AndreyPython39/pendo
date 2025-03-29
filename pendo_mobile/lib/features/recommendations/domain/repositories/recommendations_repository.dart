import '../models/recommendation.dart';
import '../../../shared/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RecommendationsRepository {
  /// Получение рекомендаций
  Future<List<Recommendation>> getRecommendations({
    required int limit,
    required int offset,
  });

  /// Лайк пользователя
  Future<void> likeUser(int userId);

  /// Пропуск пользователя
  Future<void> passUser(int userId);

  /// Получение настроек рекомендаций
  Future<Map<String, dynamic>> getRecommendationSettings();

  /// Обновление настроек рекомендаций
  Future<void> updateRecommendationSettings(Map<String, dynamic> settings);
}

class RecommendationsRepositoryImpl implements RecommendationsRepository {
  final ApiClient apiClient;

  RecommendationsRepositoryImpl({required this.apiClient});

  @override
  Future<List<Recommendation>> getRecommendations({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await apiClient.get(
        '/recommendations',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      return (response.data['recommendations'] as List)
          .map((json) => Recommendation.fromJson(json))
          .toList();
    } catch (e) {
      throw Failure('Failed to load recommendations: $e');
    }
  }

  @override
  Future<void> likeUser(int userId) async {
    try {
      await apiClient.post('/recommendations/$userId/like');
    } catch (e) {
      throw Failure('Failed to like user: $e');
    }
  }

  @override
  Future<void> passUser(int userId) async {
    try {
      await apiClient.post('/recommendations/$userId/pass');
    } catch (e) {
      throw Failure('Failed to pass user: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getRecommendationSettings() async {
    try {
      final response = await apiClient.get('/recommendations/settings');
      return response.data;
    } catch (e) {
      throw Failure('Failed to load recommendation settings: $e');
    }
  }

  @override
  Future<void> updateRecommendationSettings(
      Map<String, dynamic> settings) async {
    try {
      await apiClient.put(
        '/recommendations/settings',
        data: settings,
      );
    } catch (e) {
      throw Failure('Failed to update recommendation settings: $e');
    }
  }
}
