import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/features/discover/presentation/bloc/shout_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShoutList extends StatefulWidget {
  const ShoutList({super.key});

  @override
  State<ShoutList> createState() => _ShoutListState();
}

class _ShoutListState extends State<ShoutList> {
  @override
  void initState() {
    super.initState();
    context.read<ShoutBloc>().add(const LoadShoutsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ShoutBloc, ShoutState>(
      builder: (context, state) {
        if (state is ShoutLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ShoutError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          );
        }

        if (state is ShoutLoaded) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.shouts.length,
            itemBuilder: (context, index) {
              final shout = state.shouts[index];
              return Container(
                margin: const EdgeInsets.only(right: 12),
                width: 200,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      // TODO: Open shout details
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        // Background Image
                        if (shout.media != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: shout.media!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        
                        // Gradient Overlay
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                        
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Text
                              Text(
                                shout.text,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              
                              // User Info
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundImage: CachedNetworkImageProvider(
                                      shout.user.avatar,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shout.user.name,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          shout.tribe?.name ?? '',
                                          style:
                                              theme.textTheme.bodySmall?.copyWith(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Reactions
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Column(
                            children: [
                              _ReactionButton(
                                icon: Icons.local_fire_department,
                                count: shout.fireCount,
                                color: Colors.orange,
                                onTap: () {
                                  context.read<ShoutBloc>().add(
                                        ReactToShoutEvent(
                                          shoutId: shout.id,
                                          reaction: ShoutReaction.fire,
                                        ),
                                      );
                                },
                              ),
                              const SizedBox(height: 8),
                              _ReactionButton(
                                icon: Icons.favorite,
                                count: shout.heartCount,
                                color: Colors.red,
                                onTap: () {
                                  context.read<ShoutBloc>().add(
                                        ReactToShoutEvent(
                                          shoutId: shout.id,
                                          reaction: ShoutReaction.heart,
                                        ),
                                      );
                                },
                              ),
                              const SizedBox(height: 8),
                              _ReactionButton(
                                icon: Icons.remove_red_eye,
                                count: shout.viewCount,
                                color: Colors.blue,
                                onTap: () {
                                  context.read<ShoutBloc>().add(
                                        ReactToShoutEvent(
                                          shoutId: shout.id,
                                          reaction: ShoutReaction.view,
                                        ),
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class _ReactionButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color color;
  final VoidCallback onTap;

  const _ReactionButton({
    required this.icon,
    required this.count,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(height: 2),
              Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
