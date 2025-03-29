import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift.freezed.dart';
part 'gift.g.dart';

@freezed
class VirtualGiftModel with _$VirtualGiftModel {
  const factory VirtualGiftModel({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'animation_url') String? animationUrl,
    required int price,
    @JsonKey(name: 'cultural_significance') String? culturalSignificance,
    @JsonKey(name: 'cultural_category') String? culturalCategory,
    @JsonKey(name: 'is_premium') required bool isPremium,
  }) = _VirtualGiftModel;

  factory VirtualGiftModel.fromJson(Map<String, dynamic> json) =>
      _$VirtualGiftModelFromJson(json);
}

@freezed
class GiftTransactionModel with _$GiftTransactionModel {
  const factory GiftTransactionModel({
    required String id,
    @JsonKey(name: 'gift_id') required String giftId,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'receiver_id') required String receiverId,
    String? message,
    required int price,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _GiftTransactionModel;

  factory GiftTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$GiftTransactionModelFromJson(json);
}

@freezed
class GiftCollectionModel with _$GiftCollectionModel {
  const factory GiftCollectionModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'gift_id') required String giftId,
    required int count,
    @JsonKey(name: 'first_received') required DateTime firstReceived,
    @JsonKey(name: 'last_received') required DateTime lastReceived,
  }) = _GiftCollectionModel;

  factory GiftCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$GiftCollectionModelFromJson(json);
}
