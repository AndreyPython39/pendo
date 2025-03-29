import 'package:dio/dio.dart';
import '../../../core/api/api_client.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/models/gift.dart';

class GiftRepository {
  final ApiClient _apiClient;

  GiftRepository(this._apiClient);

  Future<List<Gift>> getGifts({
    bool? isPremium,
    bool? isAnimated,
  }) async {
    try {
      final queryParams = {
        if (isPremium != null) 'is_premium': isPremium,
        if (isAnimated != null) 'is_animated': isAnimated,
      };

      final response = await _apiClient.get(
        '/gifts',
        queryParameters: queryParams,
      );

      return (response.data as List)
          .map((json) => Gift.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<void> sendGift({
    required int giftId,
    required int receiverId,
  }) async {
    try {
      await _apiClient.post(
        '/gifts/$giftId/send/$receiverId',
      );
    } on DioError catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<List<Gift>> getReceivedGifts() async {
    try {
      final response = await _apiClient.get('/gifts/received');
      return (response.data as List)
          .map((json) => Gift.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<List<Gift>> getSentGifts() async {
    try {
      final response = await _apiClient.get('/gifts/sent');
      return (response.data as List)
          .map((json) => Gift.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw ServerException(e.message);
    }
  }
}
