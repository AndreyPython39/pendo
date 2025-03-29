import 'package:dio/dio.dart';
import '../models/subscription_model.dart';
import '../../domain/repositories/i_premium_repository.dart';

class PremiumRepository implements IPremiumRepository {
  final Dio _dio;

  PremiumRepository(this._dio);

  @override
  Future<List<SubscriptionModel>> getSubscriptions() async {
    final response = await _dio.get('/subscriptions');
    return (response.data as List)
        .map((json) => SubscriptionModel.fromJson(json))
        .toList();
  }

  @override
  Future<PurchaseModel> purchaseSubscription(String subscriptionId) async {
    final response = await _dio.post('/subscriptions/$subscriptionId/purchase');
    return PurchaseModel.fromJson(response.data);
  }

  @override
  Future<void> cancelSubscription() async {
    await _dio.post('/subscriptions/cancel');
  }

  @override
  Future<List<FeatureAccessModel>> getFeatureAccess() async {
    final response = await _dio.get('/premium/features');
    return (response.data as List)
        .map((json) => FeatureAccessModel.fromJson(json))
        .toList();
  }

  @override
  Future<bool> checkFeatureAccess(String featureId) async {
    try {
      final response = await _dio.get('/premium/features/$featureId/access');
      return response.data['hasAccess'] ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> consumeFeature(String featureId) async {
    await _dio.post('/premium/features/$featureId/consume');
  }

  @override
  Future<void> restorePurchases() async {
    await _dio.post('/subscriptions/restore');
  }
}
