import 'package:equatable/equatable.dart';
import 'package:pendo_mobile/features/chat/data/models/message_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ConversationsLoaded extends ChatState {
  final List<ConversationModel> conversations;
  final bool hasMore;

  const ConversationsLoaded({
    required this.conversations,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [conversations, hasMore];
}

class MessagesLoaded extends ChatState {
  final String conversationId;
  final List<MessageModel> messages;
  final bool hasMore;

  const MessagesLoaded({
    required this.conversationId,
    required this.messages,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [conversationId, messages, hasMore];
}

class MessageSent extends ChatState {
  final MessageModel message;

  const MessageSent(this.message);

  @override
  List<Object?> get props => [message];
}

class MessageDeleted extends ChatState {
  final String messageId;

  const MessageDeleted(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

class ConversationMarkedAsRead extends ChatState {
  final String conversationId;

  const ConversationMarkedAsRead(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class ConversationDeleted extends ChatState {
  final String conversationId;

  const ConversationDeleted(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class IcebreakersLoaded extends ChatState {
  final List<IcebreakerModel> icebreakers;

  const IcebreakersLoaded(this.icebreakers);

  @override
  List<Object?> get props => [icebreakers];
}

class TypingStatusChanged extends ChatState {
  final String conversationId;
  final String userId;
  final bool isTyping;

  const TypingStatusChanged({
    required this.conversationId,
    required this.userId,
    required this.isTyping,
  });

  @override
  List<Object?> get props => [conversationId, userId, isTyping];
}

class AttachmentUploading extends ChatState {
  final String conversationId;
  final double progress;

  const AttachmentUploading({
    required this.conversationId,
    required this.progress,
  });

  @override
  List<Object?> get props => [conversationId, progress];
}

class AttachmentUploaded extends ChatState {
  final MessageModel message;

  const AttachmentUploaded(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
