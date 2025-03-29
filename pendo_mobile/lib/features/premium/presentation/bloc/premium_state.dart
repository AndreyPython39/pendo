part of 'premium_bloc.dart';

@freezed
class PremiumState with _$PremiumState {
  const factory PremiumState.initial() = _Initial;
  const factory PremiumState.loading() = _Loading;
  const factory PremiumState.subscriptionsLoaded(List<SubscriptionModel> subscriptions) = _SubscriptionsLoaded;
  const factory PremiumState.purchased(PurchaseModel purchase) = _Purchased;
  const factory PremiumState.cancelled() = _Cancelled;
  const factory PremiumState.restored(List<SubscriptionModel> subscriptions) = _Restored;
  const factory PremiumState.featureChecked(String featureId, bool hasAccess) = _FeatureChecked;
  const factory PremiumState.featuresLoaded(List<FeatureAccessModel> features) = _FeaturesLoaded;
  const factory PremiumState.error(String message) = _Error;
}
