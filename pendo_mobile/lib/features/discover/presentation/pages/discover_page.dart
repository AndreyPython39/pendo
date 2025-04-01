import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:pendo_mobile/features/discover/presentation/widgets/profile_card.dart';
import 'package:pendo_mobile/features/discover/presentation/widgets/shout_list.dart';
import 'package:pendo_mobile/features/discover/presentation/widgets/story_bar.dart';
import 'package:pendo_mobile/shared/widgets/loading_indicator.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    context.read<DiscoverBloc>().add(const LoadProfilesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Stories
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const StoryBar(),
            ),
            
            // Main Content
            Expanded(
              child: BlocBuilder<DiscoverBloc, DiscoverState>(
                builder: (context, state) {
                  if (state is DiscoverLoading) {
                    return const LoadingIndicator();
                  }
                  
                  if (state is DiscoverError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    );
                  }
                  
                  if (state is DiscoverLoaded) {
                    if (state.profiles.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: theme.colorScheme.outline,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No more profiles to show',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try changing your filters',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Stack(
                      children: [
                        // Profile Cards
                        ProfileCard(
                          profiles: state.profiles,
                          onSwipeLeft: (profile) {
                            context.read<DiscoverBloc>().add(
                                  SwipeProfileEvent(
                                    profileId: profile.id,
                                    direction: SwipeDirection.left,
                                  ),
                                );
                          },
                          onSwipeRight: (profile) {
                            context.read<DiscoverBloc>().add(
                                  SwipeProfileEvent(
                                    profileId: profile.id,
                                    direction: SwipeDirection.right,
                                  ),
                                );
                          },
                          onSuperLike: (profile) {
                            context.read<DiscoverBloc>().add(
                                  SwipeProfileEvent(
                                    profileId: profile.id,
                                    direction: SwipeDirection.up,
                                  ),
                                );
                          },
                        ),
                        
                        // Shout List (at the bottom)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  theme.colorScheme.surface,
                                ],
                              ),
                            ),
                            child: const ShoutList(),
                          ),
                        ),
                      ],
                    );
                  }
                  
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
