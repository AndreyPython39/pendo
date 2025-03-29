import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadConversationsEvent extends ChatEvent {
  final int? page;
  final int? limit;

  const LoadConversationsEvent({
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [page, limit];
}

class LoadMessagesEvent extends ChatEvent {
  final String conversationId;
  final int? page;
  final int? limit;

  const LoadMessagesEvent({
    required this.conversationId,
    this.page,
    this.limit,
  });

  @override
  List<Object?> get props => [conversationId, page, limit];
}

class SendMessageEvent extends ChatEvent {
  final String conversationId;
  final String content;
  final String type;
  final Map<String, dynamic>? metadata;

  const SendMessageEvent({
    required this.conversationId,
    required this.content,
    required this.type,
    this.metadata,
  });

  @override
  List<Object?> get props => [conversationId, content, type, metadata];
}

class DeleteMessageEvent extends ChatEvent {
  final String messageId;

  const DeleteMessageEvent(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

class MarkAsReadEvent extends ChatEvent {
  final String conversationId;

  const MarkAsReadEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class DeleteConversationEvent extends ChatEvent {
  final String conversationId;

  const DeleteConversationEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class LoadIcebreakersEvent extends ChatEvent {
  final String? category;
  final String? language;

  const LoadIcebreakersEvent({
    this.category,
    this.language,
  });

  @override
  List<Object?> get props => [category, language];
}

class StartTypingEvent extends ChatEvent {
  final String conversationId;

  const StartTypingEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class StopTypingEvent extends ChatEvent {
  final String conversationId;

  const StopTypingEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class UploadAttachmentEvent extends ChatEvent {
  final String conversationId;
  final String filePath;
  final String type;
  final Map<String, dynamic>? metadata;

  const UploadAttachmentEvent({
    required this.conversationId,
    required this.filePath,
    required this.type,
    this.metadata,
  });

  @override
  List<Object?> get props => [conversationId, filePath, type, metadata];
}
