import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_model.freezed.dart';
part 'gift_model.g.dart';

@freezed
class GiftModel with _$GiftModel {
  const factory GiftModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required int coins,
    required bool isAnimated,
    String? animationUrl,
    required Map<String, dynamic> metadata,
    required DateTime createdAt,
  }) = _GiftModel;

  factory GiftModel.fromJson(Map<String, dynamic> json) =>
      _$GiftModelFromJson(json);
}

@freezed
class GiftTransactionModel with _$GiftTransactionModel {
  const factory GiftTransactionModel({
    required String id,
    required String senderId,
    required String receiverId,
    required String giftId,
    required int coins,
    String? message,
    required DateTime sentAt,
    required bool isAnonymous,
  }) = _GiftTransactionModel;

  factory GiftTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$GiftTransactionModelFromJson(json);
}

@freezed
class GiftPackageModel with _$GiftPackageModel {
  const factory GiftPackageModel({
    required String id,
    required String name,
    required String description,
    required int coins,
    required double price,
    required String currency,
    required bool isPopular,
    required bool isLimited,
    DateTime? expiresAt,
    required Map<String, dynamic> metadata,
  }) = _GiftPackageModel;

  factory GiftPackageModel.fromJson(Map<String, dynamic> json) =>
      _$GiftPackageModelFromJson(json);
}
