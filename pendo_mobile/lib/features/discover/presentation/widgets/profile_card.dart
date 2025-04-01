import 'package:flutter/material.dart';
import 'package:pendo_mobile/features/discover/domain/entities/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class ProfileCard extends StatefulWidget {
  final List<Profile> profiles;
  final Function(Profile) onSwipeLeft;
  final Function(Profile) onSwipeRight;
  final Function(Profile) onSuperLike;

  const ProfileCard({
    super.key,
    required this.profiles,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onSuperLike,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late CardSwiperController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CardSwiperController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        // Cards
        CardSwiper(
          controller: _controller,
          cardsCount: widget.profiles.length,
          onSwipe: (previousIndex, currentIndex, direction) {
            final profile = widget.profiles[previousIndex];
            switch (direction) {
              case CardSwiperDirection.left:
                widget.onSwipeLeft(profile);
                break;
              case CardSwiperDirection.right:
                widget.onSwipeRight(profile);
                break;
              case CardSwiperDirection.top:
                widget.onSuperLike(profile);
                break;
              default:
                break;
            }
            return true;
          },
          cardBuilder: (context, index) {
            final profile = widget.profiles[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Profile Image
                    CachedNetworkImage(
                      imageUrl: profile.photos.first,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: theme.colorScheme.surface,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: theme.colorScheme.surface,
                        child: Icon(
                          Icons.error_outline,
                          color: theme.colorScheme.error,
                          size: 48,
                        ),
                      ),
                    ),
                    
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                    
                    // Profile Info
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Name and Age
                          Row(
                            children: [
                              Text(
                                profile.name,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                profile.age.toString(),
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          
                          // Location
                          if (profile.location != null)
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  profile.location!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 8),
                          
                          // Interests
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: profile.interests.take(3).map((interest) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer
                                      .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  interest,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        
        // Action Buttons
        Positioned(
          left: 0,
          right: 0,
          bottom: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Pass Button
              FloatingActionButton(
                heroTag: 'pass',
                onPressed: () => _controller.swipeLeft(),
                backgroundColor: theme.colorScheme.errorContainer,
                child: Icon(
                  Icons.close,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
              
              // Super Like Button
              FloatingActionButton(
                heroTag: 'superlike',
                onPressed: () => _controller.swipeTop(),
                backgroundColor: theme.colorScheme.tertiaryContainer,
                child: Icon(
                  Icons.star,
                  color: theme.colorScheme.onTertiaryContainer,
                ),
              ),
              
              // Like Button
              FloatingActionButton(
                heroTag: 'like',
                onPressed: () => _controller.swipeRight(),
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.favorite,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
