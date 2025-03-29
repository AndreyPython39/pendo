part of 'premium_bloc.dart';

@freezed
class PremiumEvent with _$PremiumEvent {
  const factory PremiumEvent.loadSubscriptions() = _LoadSubscriptions;
  const factory PremiumEvent.purchase(String subscriptionId) = _Purchase;
  const factory PremiumEvent.cancel() = _Cancel;
  const factory PremiumEvent.restore() = _Restore;
  const factory PremiumEvent.checkFeature(String featureId) = _CheckFeature;
  const factory PremiumEvent.loadFeatures() = _LoadFeatures;
}
