import 'package:flutter/material.dart';
import 'package:pendo_mobile/features/tribes/data/models/tribe_model.dart';
import 'package:intl/intl.dart';

class TribeEventCard extends StatelessWidget {
  final TribeEventModel event;
  final VoidCallback? onTap;
  final VoidCallback? onJoin;
  final VoidCallback? onLeave;

  const TribeEventCard({
    super.key,
    required this.event,
    this.onTap,
    this.onJoin,
    this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAttending = event.attendees
        .any((user) => user.id.toString() == 'current_user_id'); // TODO: Get from auth

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date banner
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              color: theme.colorScheme.primary,
              child: Row(
                children: [
                  Icon(
                    Icons.event,
                    color: theme.colorScheme.onPrimary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('EEE, MMM d • h:mm a').format(event.startTime),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[600],
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.description,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _AttendeesList(attendees: event.attendees),
                      ),
                      const SizedBox(width: 16),
                      if (isAttending && onLeave != null)
                        OutlinedButton(
                          onPressed: onLeave,
                          child: const Text('Leave'),
                        )
                      else if (!isAttending && onJoin != null)
                        ElevatedButton(
                          onPressed: onJoin,
                          child: const Text('Join'),
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

class _AttendeesList extends StatelessWidget {
  final List<UserModel> attendees;

  const _AttendeesList({
    required this.attendees,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const maxDisplayed = 3;
    final remaining = attendees.length - maxDisplayed;

    return Row(
      children: [
        ...attendees.take(maxDisplayed).map((user) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(user.profile.photos.first),
            ),
          );
        }),
        if (remaining > 0)
          CircleAvatar(
            radius: 16,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
            child: Text(
              '+$remaining',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        const SizedBox(width: 8),
        Text(
          '${attendees.length} attending',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
