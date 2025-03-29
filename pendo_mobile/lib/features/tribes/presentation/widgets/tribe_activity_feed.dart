import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../data/models/tribe_model.dart';

class TribeActivityFeed extends StatelessWidget {
  final List<Map<String, dynamic>> activities;
  final VoidCallback? onLoadMore;

  const TribeActivityFeed({
    super.key,
    required this.activities,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length + 1,
      itemBuilder: (context, index) {
        if (index == activities.length) {
          if (onLoadMore != null) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: TextButton(
                  onPressed: onLoadMore,
                  child: const Text('Load More'),
                ),
              ),
            );
          }
          return const SizedBox();
        }

        final activity = activities[index];
        return _ActivityItem(activity: activity);
      },
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final Map<String, dynamic> activity;

  const _ActivityItem({
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(activity['userAvatar']),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['userName'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        timeago.format(DateTime.parse(activity['timestamp'])),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                _buildActivityIcon(activity['type']),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _buildActivityDescription(activity),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (activity['mediaUrl'] != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  activity['mediaUrl'],
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
            ],
            if (activity['type'] == 'vote' && activity['voteOptions'] != null) ...[
              const SizedBox(height: 12),
              _buildVotePreview(context, activity),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.comment_outlined, size: 18),
                  label: Text('${activity['commentsCount'] ?? 0}'),
                  onPressed: () {
                    // TODO: Show comments
                  },
                ),
                TextButton.icon(
                  icon: const Icon(Icons.favorite_outline, size: 18),
                  label: Text('${activity['likesCount'] ?? 0}'),
                  onPressed: () {
                    // TODO: Like activity
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'join':
        icon = Icons.person_add;
        color = Colors.green;
        break;
      case 'event':
        icon = Icons.event;
        color = Colors.blue;
        break;
      case 'vote':
        icon = Icons.how_to_vote;
        color = Colors.orange;
        break;
      case 'photo':
        icon = Icons.photo;
        color = Colors.purple;
        break;
      case 'announcement':
        icon = Icons.campaign;
        color = Colors.red;
        break;
      default:
        icon = Icons.notifications;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  String _buildActivityDescription(Map<String, dynamic> activity) {
    switch (activity['type']) {
      case 'join':
        return 'joined the tribe';
      case 'event':
        return 'created an event: ${activity['eventTitle']}';
      case 'vote':
        return 'started a vote: ${activity['voteTitle']}';
      case 'photo':
        return activity['description'] ?? 'shared a photo';
      case 'announcement':
        return activity['announcement'];
      default:
        return activity['description'] ?? '';
    }
  }

  Widget _buildVotePreview(BuildContext context, Map<String, dynamic> activity) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity['voteTitle'],
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...(activity['voteOptions'] as List<dynamic>).map((option) {
            final percentage = option['votes'] / activity['totalVotes'] * 100;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option['text']),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Theme.of(context).dividerColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${percentage.toStringAsFixed(1)}% (${option['votes']} votes)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
