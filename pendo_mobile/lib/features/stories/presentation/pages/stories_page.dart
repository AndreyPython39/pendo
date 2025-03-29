import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/stories_bloc.dart';
import '../widgets/story_viewer.dart';
import '../widgets/story_creation_sheet.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateStorySheet(context),
          ),
        ],
      ),
      body: BlocBuilder<StoriesBloc, StoriesState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (stories) => stories.isEmpty
                ? const Center(child: Text('No stories yet'))
                : ListView.builder(
                    itemCount: stories.length,
                    itemBuilder: (context, index) {
                      final story = stories[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            story.thumbnailUrl ?? story.mediaUrl,
                          ),
                        ),
                        title: Text('Story ${story.id}'),
                        subtitle: Text(
                          '${story.viewsCount} views • Expires in ${_getTimeUntilExpiry(story.expiresAt)}',
                        ),
                        onTap: () => _openStoryViewer(context, story),
                      );
                    },
                  ),
            error: (message) => Center(child: Text('Error: $message')),
          );
        },
      ),
    );
  }

  void _showCreateStorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const StoryCreationSheet(),
    );
  }

  void _openStoryViewer(BuildContext context, StoryModel story) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StoryViewer(story: story),
      ),
    );
  }

  String _getTimeUntilExpiry(DateTime expiryTime) {
    final now = DateTime.now();
    final difference = expiryTime.difference(now);
    if (difference.inHours > 0) {
      return '${difference.inHours}h';
    }
    return '${difference.inMinutes}m';
  }
}
