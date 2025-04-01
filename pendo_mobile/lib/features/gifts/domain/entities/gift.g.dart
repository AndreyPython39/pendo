// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VirtualGiftModelImpl _$$VirtualGiftModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VirtualGiftModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      animationUrl: json['animation_url'] as String?,
      price: (json['price'] as num).toInt(),
      culturalSignificance: json['cultural_significance'] as String?,
      culturalCategory: json['cultural_category'] as String?,
      isPremium: json['is_premium'] as bool,
    );

Map<String, dynamic> _$$VirtualGiftModelImplToJson(
        _$VirtualGiftModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'animation_url': instance.animationUrl,
      'price': instance.price,
      'cultural_significance': instance.culturalSignificance,
      'cultural_category': instance.culturalCategory,
      'is_premium': instance.isPremium,
    };

_$GiftTransactionModelImpl _$$GiftTransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GiftTransactionModelImpl(
      id: json['id'] as String,
      giftId: json['gift_id'] as String,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      message: json['message'] as String?,
      price: (json['price'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$GiftTransactionModelImplToJson(
        _$GiftTransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gift_id': instance.giftId,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'message': instance.message,
      'price': instance.price,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$GiftCollectionModelImpl _$$GiftCollectionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GiftCollectionModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      giftId: json['gift_id'] as String,
      count: (json['count'] as num).toInt(),
      firstReceived: DateTime.parse(json['first_received'] as String),
      lastReceived: DateTime.parse(json['last_received'] as String),
    );

Map<String, dynamic> _$$GiftCollectionModelImplToJson(
        _$GiftCollectionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'gift_id': instance.giftId,
      'count': instance.count,
      'first_received': instance.firstReceived.toIso8601String(),
      'last_received': instance.lastReceived.toIso8601String(),
    };
