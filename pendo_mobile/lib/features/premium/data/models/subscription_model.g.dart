// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionModelImpl _$$SubscriptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      period: json['period'] as String,
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      isActive: json['isActive'] as bool,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      productId: json['productId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SubscriptionModelImplToJson(
        _$SubscriptionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'currency': instance.currency,
      'period': instance.period,
      'features': instance.features,
      'isActive': instance.isActive,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'productId': instance.productId,
      'metadata': instance.metadata,
    };

_$PurchaseModelImpl _$$PurchaseModelImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      subscriptionId: json['subscriptionId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      platformTransactionId: json['platformTransactionId'] as String?,
      receipt: json['receipt'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PurchaseModelImplToJson(_$PurchaseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'subscriptionId': instance.subscriptionId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'platformTransactionId': instance.platformTransactionId,
      'receipt': instance.receipt,
      'metadata': instance.metadata,
    };

_$FeatureAccessModelImpl _$$FeatureAccessModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FeatureAccessModelImpl(
      featureId: json['featureId'] as String,
      name: json['name'] as String,
      isEnabled: json['isEnabled'] as bool,
      limit: (json['limit'] as num).toInt(),
      used: (json['used'] as num).toInt(),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$FeatureAccessModelImplToJson(
        _$FeatureAccessModelImpl instance) =>
    <String, dynamic>{
      'featureId': instance.featureId,
      'name': instance.name,
      'isEnabled': instance.isEnabled,
      'limit': instance.limit,
      'used': instance.used,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'metadata': instance.metadata,
    };
