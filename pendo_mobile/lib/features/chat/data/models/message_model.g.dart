// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'content': instance.content,
      'type': instance.type,
      'timestamp': instance.timestamp.toIso8601String(),
      'isRead': instance.isRead,
      'metadata': instance.metadata,
    };

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      id: json['id'] as String,
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastMessageContent: json['lastMessageContent'] as String?,
      lastMessageTime: json['lastMessageTime'] == null
          ? null
          : DateTime.parse(json['lastMessageTime'] as String),
      isGroup: json['isGroup'] as bool,
      groupName: json['groupName'] as String?,
      groupAvatar: json['groupAvatar'] as String?,
      unreadCount: Map<String, int>.from(json['unreadCount'] as Map),
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participantIds': instance.participantIds,
      'lastMessageContent': instance.lastMessageContent,
      'lastMessageTime': instance.lastMessageTime?.toIso8601String(),
      'isGroup': instance.isGroup,
      'groupName': instance.groupName,
      'groupAvatar': instance.groupAvatar,
      'unreadCount': instance.unreadCount,
    };

IcebreakerModel _$IcebreakerModelFromJson(Map<String, dynamic> json) =>
    IcebreakerModel(
      id: json['id'] as String,
      question: json['question'] as String,
      category: json['category'] as String,
      translations: Map<String, String>.from(json['translations'] as Map),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$IcebreakerModelToJson(IcebreakerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'category': instance.category,
      'translations': instance.translations,
      'isActive': instance.isActive,
    };
