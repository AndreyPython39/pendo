// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PremiumSubscriptionModelImpl _$$PremiumSubscriptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PremiumSubscriptionModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      plan: json['plan'] as String,
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: DateTime.parse(json['ends_at'] as String),
      isActive: json['is_active'] as bool,
      autoRenew: json['auto_renew'] as bool,
      paymentMethod: json['payment_method'] as String,
    );

Map<String, dynamic> _$$PremiumSubscriptionModelImplToJson(
        _$PremiumSubscriptionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'plan': instance.plan,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt.toIso8601String(),
      'is_active': instance.isActive,
      'auto_renew': instance.autoRenew,
      'payment_method': instance.paymentMethod,
    };

_$BoostModelImpl _$$BoostModelImplFromJson(Map<String, dynamic> json) =>
    _$BoostModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: json['type'] as String,
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: DateTime.parse(json['ends_at'] as String),
      isActive: json['is_active'] as bool,
      boostMultiplier: (json['boost_multiplier'] as num).toDouble(),
    );

Map<String, dynamic> _$$BoostModelImplToJson(_$BoostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'type': instance.type,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt.toIso8601String(),
      'is_active': instance.isActive,
      'boost_multiplier': instance.boostMultiplier,
    };

_$PremiumFeatureModelImpl _$$PremiumFeatureModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PremiumFeatureModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      isEnabled: json['is_enabled'] as bool,
      requiresSubscription: json['requires_subscription'] as bool,
      featureType: json['feature_type'] as String,
    );

Map<String, dynamic> _$$PremiumFeatureModelImplToJson(
        _$PremiumFeatureModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'is_enabled': instance.isEnabled,
      'requires_subscription': instance.requiresSubscription,
      'feature_type': instance.featureType,
    };
