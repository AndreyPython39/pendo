import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/features/chat/domain/repositories/chat_repository.dart';
import 'package:pendo_mobile/features/chat/presentation/bloc/chat_event.dart';
import 'package:pendo_mobile/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription? _messageSubscription;
  StreamSubscription? _typingSubscription;
  StreamSubscription? _conversationSubscription;

  ChatBloc(this._chatRepository) : super(ChatInitial()) {
    on<LoadConversationsEvent>(_onLoadConversations);
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<DeleteMessageEvent>(_onDeleteMessage);
    on<MarkAsReadEvent>(_onMarkAsRead);
    on<DeleteConversationEvent>(_onDeleteConversation);
    on<LoadIcebreakersEvent>(_onLoadIcebreakers);
    on<StartTypingEvent>(_onStartTyping);
    on<StopTypingEvent>(_onStopTyping);
    on<UploadAttachmentEvent>(_onUploadAttachment);

    _subscribeToUpdates();
  }

  void _subscribeToUpdates() {
    _messageSubscription = _chatRepository.onMessageReceived().listen(
      (message) {
        // Handle new message
        add(LoadMessagesEvent(conversationId: message.conversationId));
      },
    );

    _typingSubscription = _chatRepository.onTypingStatusChanged().listen(
      (userId) {
        // Handle typing status
        // emit(TypingStatusChanged(userId: userId, isTyping: true));
      },
    );

    _conversationSubscription = _chatRepository.onConversationUpdated().listen(
      (data) {
        // Handle conversation updates
        add(const LoadConversationsEvent());
      },
    );
  }

  Future<void> _onLoadConversations(
    LoadConversationsEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoading());
      final conversations = await _chatRepository.getConversations(
        page: event.page,
        limit: event.limit,
      );
      emit(ConversationsLoaded(conversations: conversations));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoading());
      final messages = await _chatRepository.getMessages(
        conversationId: event.conversationId,
        page: event.page,
        limit: event.limit,
      );
      emit(MessagesLoaded(
        conversationId: event.conversationId,
        messages: messages,
      ));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final message = await _chatRepository.sendMessage(
        conversationId: event.conversationId,
        content: event.content,
        type: event.type,
        metadata: event.metadata,
      );
      emit(MessageSent(message));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onDeleteMessage(
    DeleteMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _chatRepository.deleteMessage(event.messageId);
      emit(MessageDeleted(event.messageId));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onMarkAsRead(
    MarkAsReadEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _chatRepository.markConversationAsRead(event.conversationId);
      emit(ConversationMarkedAsRead(event.conversationId));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onDeleteConversation(
    DeleteConversationEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _chatRepository.deleteConversation(event.conversationId);
      emit(ConversationDeleted(event.conversationId));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onLoadIcebreakers(
    LoadIcebreakersEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoading());
      final icebreakers = await _chatRepository.getIcebreakers(
        category: event.category,
        language: event.language,
      );
      emit(IcebreakersLoaded(icebreakers));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onStartTyping(
    StartTypingEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _chatRepository.typing(
        conversationId: event.conversationId,
        isTyping: true,
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onStopTyping(
    StopTypingEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _chatRepository.typing(
        conversationId: event.conversationId,
        isTyping: false,
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onUploadAttachment(
    UploadAttachmentEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(AttachmentUploading(
        conversationId: event.conversationId,
        progress: 0,
      ));

      await _chatRepository.uploadAttachment(
        conversationId: event.conversationId,
        filePath: event.filePath,
        type: event.type,
        metadata: event.metadata,
      );

      // After upload, send message with attachment
      final message = await _chatRepository.sendMessage(
        conversationId: event.conversationId,
        content: event.filePath,
        type: event.type,
        metadata: event.metadata,
      );

      emit(AttachmentUploaded(message));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _typingSubscription?.cancel();
    _conversationSubscription?.cancel();
    return super.close();
  }
}
