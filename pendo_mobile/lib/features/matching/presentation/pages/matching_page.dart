import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/features/auth/data/models/user_model.dart';
import 'package:pendo_mobile/features/matching/presentation/bloc/matching_bloc.dart';
import 'package:pendo_mobile/features/matching/presentation/bloc/matching_event.dart';
import 'package:pendo_mobile/features/matching/presentation/bloc/matching_state.dart';
import 'package:pendo_mobile/features/matching/presentation/widgets/swipe_buttons.dart';
import 'package:pendo_mobile/features/matching/presentation/widgets/swipe_card.dart';
import 'package:swipable_stack/swipable_stack.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({super.key});

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> with SingleTickerProviderStateMixin {
  late SwipableStackController _controller;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  List<UserModel> _profiles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()
      ..addListener(() {
        // Load more profiles when we're running low
        if (_profiles.isNotEmpty &&
            _controller.currentIndex >= _profiles.length - 3) {
          _loadMoreProfiles();
        }
      });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Initial load
    _loadMoreProfiles();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadMoreProfiles() {
    if (!_isLoading) {
      context.read<MatchingBloc>().add(const LoadProfilesEvent());
    }
  }

  void _onSwipe(int index, SwipeDirection direction) {
    final user = _profiles[index];
    switch (direction) {
      case SwipeDirection.right:
        context.read<MatchingBloc>().add(
              SwipeEvent(
                userId: user.id.toString(),
                action: 'like',
              ),
            );
        break;
      case SwipeDirection.left:
        context.read<MatchingBloc>().add(
              SwipeEvent(
                userId: user.id.toString(),
                action: 'pass',
              ),
            );
        break;
      case SwipeDirection.up:
        context.read<MatchingBloc>().add(
              SuperLikeEvent(user.id.toString()),
            );
        break;
      default:
        break;
    }
  }

  void _onSuperLike(UserModel profile) {
    // Handle super like
    _showSuperLikeAnimation();
  }

  void _showSuperLikeAnimation() {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Super Like Sent!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontFamily: 'AfricanSpirit',
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MatchingBloc, MatchingState>(
        listener: (context, state) {
          if (state is ProfilesLoaded) {
            setState(() {
              _profiles = state.profiles;
              _isLoading = false;
            });
          } else if (state is MatchingLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is SwipeSuccess && state.isMatch) {
            // Show match dialog
            showDialog(
              context: context,
              builder: (context) => _MatchDialog(match: state.match!),
            );
          } else if (state is MatchingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (_profiles.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Background with African pattern
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            image: const DecorationImage(
                              image: AssetImage('assets/images/african_pattern.png'),
                              opacity: 0.1,
                              repeat: ImageRepeat.repeat,
                            ),
                          ),
                        ),
                      ),
                      // Swipe cards
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Transform.rotate(
                              angle: _rotationAnimation.value,
                              child: SwipableStack(
                                controller: _controller,
                                onSwipeCompleted: _onSwipe,
                                overlayBuilder: (_, properties) {
                                  final opacity = min(properties.swipeProgress, 1.0);
                                  final isRight = properties.direction == SwipeDirection.right;
                                  final isLeft = properties.direction == SwipeDirection.left;
                                  final isUp = properties.direction == SwipeDirection.up;

                                  return Stack(
                                    children: [
                                      if (isRight)
                                        _SwipeOverlay(
                                          color: Colors.green,
                                          icon: Icons.favorite,
                                          text: 'LIKE',
                                          opacity: opacity,
                                        ),
                                      if (isLeft)
                                        _SwipeOverlay(
                                          color: Colors.red,
                                          icon: Icons.close,
                                          text: 'PASS',
                                          opacity: opacity,
                                        ),
                                      if (isUp)
                                        _SwipeOverlay(
                                          color: Colors.blue,
                                          icon: Icons.star,
                                          text: 'SUPER LIKE',
                                          opacity: opacity,
                                        ),
                                    ],
                                  );
                                },
                                builder: (_, properties) {
                                  final index = properties.index % _profiles.length;
                                  return SwipeCard(
                                    user: _profiles[index],
                                    onTap: () {
                                      // TODO: Navigate to profile details
                                    },
                                    onSwipeRight: (profile) {
                                      _onSwipe(index, SwipeDirection.right);
                                      _animationController.forward().then((_) {
                                        _animationController.reset();
                                      });
                                    },
                                    onSwipeLeft: (profile) {
                                      _onSwipe(index, SwipeDirection.left);
                                      _animationController.forward().then((_) {
                                        _animationController.reset();
                                      });
                                    },
                                    onSuperLike: (profile) {
                                      _onSuperLike(profile);
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Action buttons
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SwipeButtons(
                    onPass: () {
                      _controller.next(swipeDirection: SwipeDirection.left);
                    },
                    onLike: () {
                      _controller.next(swipeDirection: SwipeDirection.right);
                    },
                    onSuperLike: () {
                      _controller.next(swipeDirection: SwipeDirection.up);
                    },
                    onBoost: () {
                      // TODO: Show boost dialog
                    },
                    onRewind: () {
                      context.read<MatchingBloc>().add(RewindEvent());
                    },
                    isPremium: true, // TODO: Get from user state
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SwipeOverlay extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final double opacity;

  const _SwipeOverlay({
    required this.color,
    required this.icon,
    required this.text,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color.withOpacity(opacity),
          width: 4,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(opacity * 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color.withOpacity(opacity),
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                  color: color.withOpacity(opacity),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchDialog extends StatelessWidget {
  final MatchModel match;

  const _MatchDialog({
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'It\'s a Match!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You and ${match.user.profile.name} have liked each other',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(
                    match.user.profile.photos.first,
                  ),
                ),
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 32,
                ),
                const CircleAvatar(
                  radius: 48,
                  // TODO: Get current user photo
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to chat
                Navigator.pop(context);
              },
              child: const Text('Send Message'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Keep Swiping'),
            ),
          ],
        ),
      ),
    );
  }
}
