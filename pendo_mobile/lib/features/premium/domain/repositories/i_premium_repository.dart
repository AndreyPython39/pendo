import '../../data/models/subscription_model.dart';

abstract class IPremiumRepository {
  Future<List<SubscriptionModel>> getSubscriptions();
  Future<PurchaseModel> purchaseSubscription(String subscriptionId);
  Future<void> cancelSubscription();
  Future<List<FeatureAccessModel>> getFeatureAccess();
  Future<bool> checkFeatureAccess(String featureId);
  Future<void> consumeFeature(String featureId);
  Future<void> restorePurchases();
}
