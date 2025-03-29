import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/features/chat/data/models/message_model.dart';
import 'package:pendo_mobile/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:pendo_mobile/features/chat/presentation/bloc/chat_event.dart';
import 'package:pendo_mobile/features/chat/presentation/bloc/chat_state.dart';
import 'package:pendo_mobile/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:pendo_mobile/features/chat/presentation/widgets/chat_input.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;
  final String title;
  final String? avatar;

  const ChatPage({
    super.key,
    required this.conversationId,
    required this.title,
    this.avatar,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();
  List<MessageModel> _messages = [];
  bool _isLoading = false;
  bool _hasMore = true;
  String? _typingUserId;

  @override
  void initState() {
    super.initState();
    _loadMessages();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _loadMessages();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    if (!_isLoading) {
      context.read<ChatBloc>().add(
            LoadMessagesEvent(
              conversationId: widget.conversationId,
              page: (_messages.length ~/ 20) + 1,
              limit: 20,
            ),
          );
    }
  }

  void _onSendMessage(String content) {
    context.read<ChatBloc>().add(
          SendMessageEvent(
            conversationId: widget.conversationId,
            content: content,
            type: 'text',
          ),
        );
  }

  void _onImageSelected(String path) {
    context.read<ChatBloc>().add(
          UploadAttachmentEvent(
            conversationId: widget.conversationId,
            filePath: path,
            type: 'image',
          ),
        );
  }

  void _onTyping(String text) {
    if (text.isNotEmpty) {
      context.read<ChatBloc>().add(
            StartTypingEvent(widget.conversationId),
          );
    } else {
      context.read<ChatBloc>().add(
            StopTypingEvent(widget.conversationId),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (widget.avatar != null) ...[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.avatar!),
              ),
              const SizedBox(width: 8),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title),
                if (_typingUserId != null)
                  Text(
                    'Typing...',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Text('Clear Chat'),
              ),
              const PopupMenuItem(
                value: 'block',
                child: Text('Block User'),
              ),
              const PopupMenuItem(
                value: 'report',
                child: Text('Report'),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'clear':
                  context.read<ChatBloc>().add(
                        DeleteConversationEvent(widget.conversationId),
                      );
                  break;
                case 'block':
                  // TODO: Implement block
                  break;
                case 'report':
                  // TODO: Implement report
                  break;
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is MessagesLoaded) {
            setState(() {
              _messages = state.messages;
              _isLoading = false;
              _hasMore = state.hasMore;
            });
          } else if (state is MessageSent) {
            setState(() {
              _messages = [state.message, ..._messages];
            });
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          } else if (state is TypingStatusChanged) {
            setState(() {
              _typingUserId = state.isTyping ? state.userId : null;
            });
          } else if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: _messages.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final message = _messages[index];
                    final isMe = message.senderId == 'current_user_id'; // TODO: Get from auth
                    final showTime = index == 0 ||
                        _messages[index - 1].senderId != message.senderId;

                    return ChatBubble(
                      message: message,
                      isMe: isMe,
                      showTime: showTime,
                    );
                  },
                ),
              ),
              ChatInput(
                onSendMessage: _onSendMessage,
                onTyping: _onTyping,
                onImageSelected: _onImageSelected,
                quickReplies: const [
                  'Hi!',
                  'How are you?',
                  'Nice to meet you!',
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
