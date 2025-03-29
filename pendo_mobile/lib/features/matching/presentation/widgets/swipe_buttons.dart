import 'package:flutter/material.dart';

class SwipeButtons extends StatelessWidget {
  final VoidCallback onLike;
  final VoidCallback onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onRewind;
  final VoidCallback? onBoost;
  final bool isPremium;

  const SwipeButtons({
    super.key,
    required this.onLike,
    required this.onPass,
    this.onSuperLike,
    this.onRewind,
    this.onBoost,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (isPremium && onRewind != null)
            _SwipeButton(
              onTap: onRewind!,
              icon: Icons.replay,
              color: Colors.amber,
              size: 40,
            ),
          _SwipeButton(
            onTap: onPass,
            icon: Icons.close,
            color: theme.colorScheme.error,
            size: 56,
          ),
          if (onSuperLike != null)
            _SwipeButton(
              onTap: onSuperLike!,
              icon: Icons.star,
              color: Colors.blue,
              size: 40,
            ),
          _SwipeButton(
            onTap: onLike,
            icon: Icons.favorite,
            color: theme.colorScheme.primary,
            size: 56,
          ),
          if (isPremium && onBoost != null)
            _SwipeButton(
              onTap: onBoost!,
              icon: Icons.bolt,
              color: Colors.purple,
              size: 40,
            ),
        ],
      ),
    );
  }
}

class _SwipeButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final double size;

  const _SwipeButton({
    required this.onTap,
    required this.icon,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}
