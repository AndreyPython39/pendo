// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GiftModelImpl _$$GiftModelImplFromJson(Map<String, dynamic> json) =>
    _$GiftModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      coins: (json['coins'] as num).toInt(),
      isAnimated: json['isAnimated'] as bool,
      animationUrl: json['animationUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$GiftModelImplToJson(_$GiftModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'coins': instance.coins,
      'isAnimated': instance.isAnimated,
      'animationUrl': instance.animationUrl,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$GiftTransactionModelImpl _$$GiftTransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GiftTransactionModelImpl(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      giftId: json['giftId'] as String,
      coins: (json['coins'] as num).toInt(),
      message: json['message'] as String?,
      sentAt: DateTime.parse(json['sentAt'] as String),
      isAnonymous: json['isAnonymous'] as bool,
    );

Map<String, dynamic> _$$GiftTransactionModelImplToJson(
        _$GiftTransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'giftId': instance.giftId,
      'coins': instance.coins,
      'message': instance.message,
      'sentAt': instance.sentAt.toIso8601String(),
      'isAnonymous': instance.isAnonymous,
    };

_$GiftPackageModelImpl _$$GiftPackageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GiftPackageModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      coins: (json['coins'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      isPopular: json['isPopular'] as bool,
      isLimited: json['isLimited'] as bool,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$GiftPackageModelImplToJson(
        _$GiftPackageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'coins': instance.coins,
      'price': instance.price,
      'currency': instance.currency,
      'isPopular': instance.isPopular,
      'isLimited': instance.isLimited,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'metadata': instance.metadata,
    };
