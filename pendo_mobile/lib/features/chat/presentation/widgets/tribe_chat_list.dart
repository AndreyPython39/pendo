import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';
import 'package:pendo_mobile/features/chat/presentation/bloc/tribe_chat_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class TribeChatList extends StatefulWidget {
  const TribeChatList({super.key});

  @override
  State<TribeChatList> createState() => _TribeChatListState();
}

class _TribeChatListState extends State<TribeChatList> {
  @override
  void initState() {
    super.initState();
    context.read<TribeChatBloc>().add(const LoadTribeChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<TribeChatBloc, TribeChatState>(
      builder: (context, state) {
        if (state is TribeChatLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TribeChatError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          );
        }

        if (state is TribeChatLoaded) {
          if (state.chats.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.groups_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tribe chats yet',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join a tribe to start chatting',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.tribes);
                    },
                    child: const Text('Browse Tribes'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.chats.length,
            itemBuilder: (context, index) {
              final chat = state.chats[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.tribeChat,
                    arguments: chat,
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      // Tribe Avatar
                      Stack(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: theme.colorScheme.primaryContainer,
                            ),
                            child: Center(
                              child: Text(
                                chat.tribe.emoji,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          if (chat.unreadCount > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  chat.unreadCount.toString(),
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      // Chat Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    chat.tribe.name,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: chat.unreadCount > 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  timeago.format(chat.lastMessage.timestamp),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: chat.unreadCount > 0
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                // Last Message User Avatar
                                CircleAvatar(
                                  radius: 8,
                                  backgroundImage: CachedNetworkImageProvider(
                                    chat.lastMessage.user.avatar,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                // Last Message
                                Expanded(
                                  child: Text(
                                    '${chat.lastMessage.user.name}: ${chat.lastMessage.text}',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: chat.unreadCount > 0
                                          ? theme.colorScheme.onBackground
                                          : theme.colorScheme.outline,
                                      fontWeight: chat.unreadCount > 0
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Active Members
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 16,
                                  color: theme.colorScheme.outline,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${chat.activeMembers} active',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.outline,
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
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
