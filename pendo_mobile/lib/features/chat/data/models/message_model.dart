import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final String type; // text, image, etc.
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? metadata;

  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.type,
    required this.timestamp,
    required this.isRead,
    this.metadata,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

@JsonSerializable()
class ConversationModel {
  final String id;
  final List<String> participantIds;
  final String? lastMessageContent;
  final DateTime? lastMessageTime;
  final bool isGroup;
  final String? groupName;
  final String? groupAvatar;
  final Map<String, int> unreadCount;

  const ConversationModel({
    required this.id,
    required this.participantIds,
    this.lastMessageContent,
    this.lastMessageTime,
    required this.isGroup,
    this.groupName,
    this.groupAvatar,
    required this.unreadCount,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}

@JsonSerializable()
class IcebreakerModel {
  final String id;
  final String question;
  final String category;
  final Map<String, String> translations;
  final bool isActive;

  const IcebreakerModel({
    required this.id,
    required this.question,
    required this.category,
    required this.translations,
    required this.isActive,
  });

  factory IcebreakerModel.fromJson(Map<String, dynamic> json) =>
      _$IcebreakerModelFromJson(json);

  Map<String, dynamic> toJson() => _$IcebreakerModelToJson(this);
}
