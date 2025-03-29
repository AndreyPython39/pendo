import 'package:freezed_annotation/freezed_annotation.dart';

part 'premium.freezed.dart';
part 'premium.g.dart';

@freezed
class PremiumSubscriptionModel with _$PremiumSubscriptionModel {
  const factory PremiumSubscriptionModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String plan, // monthly, annual
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'ends_at') required DateTime endsAt,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'auto_renew') required bool autoRenew,
    @JsonKey(name: 'payment_method') required String paymentMethod,
  }) = _PremiumSubscriptionModel;

  factory PremiumSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PremiumSubscriptionModelFromJson(json);
}

@freezed
class BoostModel with _$BoostModel {
  const factory BoostModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String type, // standard, super
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'ends_at') required DateTime endsAt,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'boost_multiplier') required double boostMultiplier,
  }) = _BoostModel;

  factory BoostModel.fromJson(Map<String, dynamic> json) =>
      _$BoostModelFromJson(json);
}

@freezed
class PremiumFeatureModel with _$PremiumFeatureModel {
  const factory PremiumFeatureModel({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'is_enabled') required bool isEnabled,
    @JsonKey(name: 'requires_subscription') required bool requiresSubscription,
    @JsonKey(name: 'feature_type') required String featureType,
  }) = _PremiumFeatureModel;

  factory PremiumFeatureModel.fromJson(Map<String, dynamic> json) =>
      _$PremiumFeatureModelFromJson(json);
}
