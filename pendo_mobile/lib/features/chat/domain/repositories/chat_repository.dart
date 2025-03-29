import 'package:pendo_mobile/features/chat/data/models/message_model.dart';

abstract class ChatRepository {
  Future<List<ConversationModel>> getConversations({
    int? page,
    int? limit,
  });

  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int? page,
    int? limit,
  });

  Future<MessageModel> sendMessage({
    required String conversationId,
    required String content,
    required String type,
    Map<String, dynamic>? metadata,
  });

  Future<void> deleteMessage(String messageId);

  Future<void> markConversationAsRead(String conversationId);

  Future<void> deleteConversation(String conversationId);

  Future<List<IcebreakerModel>> getIcebreakers({
    String? category,
    String? language,
  });

  Future<void> typing({
    required String conversationId,
    required bool isTyping,
  });

  Stream<MessageModel> onMessageReceived();

  Stream<String> onTypingStatusChanged();

  Stream<Map<String, dynamic>> onConversationUpdated();

  Future<void> uploadAttachment({
    required String conversationId,
    required String filePath,
    required String type,
    Map<String, dynamic>? metadata,
  });
}
