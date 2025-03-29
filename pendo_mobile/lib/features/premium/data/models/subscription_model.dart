import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

@freezed
class SubscriptionModel with _$SubscriptionModel {
  const factory SubscriptionModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String currency,
    required String period,
    required List<String> features,
    required bool isActive,
    DateTime? startDate,
    DateTime? endDate,
    String? productId, // Platform-specific product ID (App Store/Play Store)
    Map<String, dynamic>? metadata,
  }) = _SubscriptionModel;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);
}

@freezed
class PurchaseModel with _$PurchaseModel {
  const factory PurchaseModel({
    required String id,
    required String userId,
    required String subscriptionId,
    required double amount,
    required String currency,
    required String status,
    required DateTime purchaseDate,
    DateTime? expiryDate,
    String? platformTransactionId,
    String? receipt,
    Map<String, dynamic>? metadata,
  }) = _PurchaseModel;

  factory PurchaseModel.fromJson(Map<String, dynamic> json) =>
      _$PurchaseModelFromJson(json);
}

@freezed
class FeatureAccessModel with _$FeatureAccessModel {
  const factory FeatureAccessModel({
    required String featureId,
    required String name,
    required bool isEnabled,
    required int limit,
    required int used,
    DateTime? expiryDate,
    Map<String, dynamic>? metadata,
  }) = _FeatureAccessModel;

  factory FeatureAccessModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureAccessModelFromJson(json);
}
