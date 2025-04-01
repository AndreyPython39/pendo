import 'package:json_annotation/json_annotation.dart';

part 'gift_transaction_model.g.dart';

@JsonSerializable()
class GiftTransactionModel {
  final String id;
  
  @JsonKey(name: 'sender_id')
  final String senderId;
  
  @JsonKey(name: 'receiver_id')
  final String receiverId;
  
  @JsonKey(name: 'gift_id')
  final String giftId;
  
  @JsonKey(name: 'gift_name')
  final String giftName;
  
  @JsonKey(name: 'gift_image_url')
  final String giftImageUrl;
  
  final int coins;
  final String? message;
  
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  GiftTransactionModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.giftId,
    required this.giftName,
    required this.giftImageUrl,
    required this.coins,
    this.message,
    required this.createdAt,
  });

  factory GiftTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$GiftTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$GiftTransactionModelToJson(this);
}
