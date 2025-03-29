import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';
import 'package:pendo_mobile/features/chat/data/models/message_model.dart';
import 'package:pendo_mobile/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:pendo_mobile/features/chat/presentation/bloc/chat_event.dart';
import 'package:pendo_mobile/features/chat/presentation/bloc/chat_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  final _scrollController = ScrollController();
  List<ConversationModel> _conversations = [];
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadConversations();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _loadConversations();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadConversations() {
    if (!_isLoading) {
      context.read<ChatBloc>().add(
            LoadConversationsEvent(
              page: (_conversations.length ~/ 20) + 1,
              limit: 20,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ConversationsLoaded) {
            setState(() {
              _conversations = state.conversations;
              _isLoading = false;
              _hasMore = state.hasMore;
            });
          } else if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (_conversations.isEmpty && state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No messages yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start matching with people to chat',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _conversations.clear();
              _loadConversations();
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 8),
              itemCount: _conversations.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _conversations.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final conversation = _conversations[index];
                return _ConversationTile(
                  conversation: conversation,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.chat,
                      arguments: {
                        'conversationId': conversation.id,
                        'title': conversation.isGroup
                            ? conversation.groupName!
                            : 'User Name', // TODO: Get from user
                        'avatar': conversation.isGroup
                            ? conversation.groupAvatar
                            : 'User Avatar', // TODO: Get from user
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final ConversationModel conversation;
  final VoidCallback onTap;

  const _ConversationTile({
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unreadCount = conversation.unreadCount['current_user_id'] ?? 0; // TODO: Get from auth

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    conversation.isGroup
                        ? conversation.groupAvatar!
                        : 'User Avatar', // TODO: Get from user
                  ),
                ),
                if (conversation.isGroup)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.group,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.isGroup
                              ? conversation.groupName!
                              : 'User Name', // TODO: Get from user
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight:
                                unreadCount > 0 ? FontWeight.bold : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.lastMessageTime != null)
                        Text(
                          timeago.format(conversation.lastMessageTime!),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: unreadCount > 0
                                ? theme.colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessageContent ?? 'No messages yet',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: unreadCount > 0
                                ? theme.textTheme.bodyMedium?.color
                                : Colors.grey,
                            fontWeight:
                                unreadCount > 0 ? FontWeight.bold : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
