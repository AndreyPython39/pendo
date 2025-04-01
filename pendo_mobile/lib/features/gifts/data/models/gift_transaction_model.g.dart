// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftTransactionModel _$GiftTransactionModelFromJson(
        Map<String, dynamic> json) =>
    GiftTransactionModel(
      id: json['id'] as String,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      giftId: json['gift_id'] as String,
      giftName: json['gift_name'] as String,
      giftImageUrl: json['gift_image_url'] as String,
      coins: (json['coins'] as num).toInt(),
      message: json['message'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$GiftTransactionModelToJson(
        GiftTransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'gift_id': instance.giftId,
      'gift_name': instance.giftName,
      'gift_image_url': instance.giftImageUrl,
      'coins': instance.coins,
      'message': instance.message,
      'created_at': instance.createdAt.toIso8601String(),
    };
