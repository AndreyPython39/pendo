import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/features/tribes/data/models/tribe_model.dart';
import 'package:pendo_mobile/features/tribes/presentation/bloc/tribes_bloc.dart';
import 'package:pendo_mobile/features/tribes/presentation/bloc/tribes_event.dart';
import 'package:pendo_mobile/features/tribes/presentation/bloc/tribes_state.dart';
import 'package:pendo_mobile/features/tribes/presentation/widgets/tribe_event_card.dart';

class TribeDetailsPage extends StatefulWidget {
  final TribeModel tribe;

  const TribeDetailsPage({
    super.key,
    required this.tribe,
  });

  @override
  State<TribeDetailsPage> createState() => _TribeDetailsPageState();
}

class _TribeDetailsPageState extends State<TribeDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<TribeEventModel> _events = [];
  List<TribeVoteModel> _votes = [];
  Map<String, dynamic>? _stats;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadEvents();
    _loadVotes();
    _loadStats();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadEvents() {
    context.read<TribesBloc>().add(
          LoadEventsEvent(tribeId: widget.tribe.id),
        );
  }

  void _loadVotes() {
    context.read<TribesBloc>().add(
          LoadActiveVotesEvent(widget.tribe.id),
        );
  }

  void _loadStats() {
    context.read<TribesBloc>().add(
          LoadTribeStatsEvent(widget.tribe.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMember = widget.tribe.members
        .any((user) => user.id.toString() == 'current_user_id'); // TODO: Get from auth
    final isChief = widget.tribe.chief.id.toString() == 'current_user_id'; // TODO: Get from auth
    final isModerator = widget.tribe.moderators
        .any((user) => user.id.toString() == 'current_user_id'); // TODO: Get from auth

    return Scaffold(
      body: BlocConsumer<TribesBloc, TribesState>(
        listener: (context, state) {
          if (state is EventsLoaded) {
            setState(() {
              _events = state.events;
            });
          } else if (state is ActiveVotesLoaded) {
            setState(() {
              _votes = state.votes;
            });
          } else if (state is TribeStatsLoaded) {
            setState(() {
              _stats = state.stats;
            });
          } else if (state is TribesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          widget.tribe.coverImage,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
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
                        Positioned(
                          left: 16,
                          bottom: 16,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(widget.tribe.avatar),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.tribe.name,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${widget.tribe.members.length} members',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white70,
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
                  actions: [
                    if (isMember)
                      IconButton(
                        icon: const Icon(Icons.chat),
                        onPressed: () {
                          // TODO: Navigate to tribe chat
                        },
                      ),
                    if (isChief || isModerator)
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          // TODO: Navigate to tribe settings
                        },
                      ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        if (!isMember)
                          const PopupMenuItem(
                            value: 'join',
                            child: Text('Join Tribe'),
                          ),
                        if (isMember)
                          const PopupMenuItem(
                            value: 'leave',
                            child: Text('Leave Tribe'),
                          ),
                        const PopupMenuItem(
                          value: 'share',
                          child: Text('Share'),
                        ),
                        const PopupMenuItem(
                          value: 'report',
                          child: Text('Report'),
                        ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 'join':
                            context
                                .read<TribesBloc>()
                                .add(JoinTribeEvent(widget.tribe.id));
                            break;
                          case 'leave':
                            context
                                .read<TribesBloc>()
                                .add(LeaveTribeEvent(widget.tribe.id));
                            break;
                          case 'share':
                            // TODO: Implement share
                            break;
                          case 'report':
                            // TODO: Implement report
                            break;
                        }
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: const [
                      Tab(text: 'About'),
                      Tab(text: 'Events'),
                      Tab(text: 'Votes'),
                      Tab(text: 'Members'),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                // About tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.tribe.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Stats',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_stats != null) ...[
                        _StatCard(
                          icon: Icons.event,
                          label: 'Events',
                          value: _stats!['events_count'].toString(),
                        ),
                        const SizedBox(height: 8),
                        _StatCard(
                          icon: Icons.how_to_vote,
                          label: 'Active Votes',
                          value: _stats!['active_votes_count'].toString(),
                        ),
                        const SizedBox(height: 8),
                        _StatCard(
                          icon: Icons.chat_bubble,
                          label: 'Messages',
                          value: _stats!['messages_count'].toString(),
                        ),
                      ],
                    ],
                  ),
                ),

                // Events tab
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    final event = _events[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TribeEventCard(
                        event: event,
                        onTap: () {
                          // TODO: Navigate to event details
                        },
                        onJoin: () {
                          context.read<TribesBloc>().add(
                                JoinEventEvent(
                                  tribeId: widget.tribe.id,
                                  eventId: event.id,
                                ),
                              );
                        },
                        onLeave: () {
                          context.read<TribesBloc>().add(
                                LeaveEventEvent(
                                  tribeId: widget.tribe.id,
                                  eventId: event.id,
                                ),
                              );
                        },
                      ),
                    );
                  },
                ),

                // Votes tab
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _votes.length,
                  itemBuilder: (context, index) {
                    final vote = _votes[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vote.title,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              vote.description,
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            ...vote.options.map((option) {
                              final votes = vote.votes[option]?.length ?? 0;
                              final totalVotes = vote.votes.values
                                  .fold(0, (sum, list) => sum + list.length);
                              final percentage =
                                  totalVotes > 0 ? votes / totalVotes : 0.0;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option,
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    LinearProgressIndicator(
                                      value: percentage,
                                      backgroundColor:
                                          theme.colorScheme.primary.withOpacity(0.1),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${(percentage * 100).toStringAsFixed(1)}% ($votes votes)',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ends in ${DateTime.now().difference(vote.endTime).inDays} days',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: Show vote dialog
                                  },
                                  child: const Text('Vote'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Members tab
                GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: widget.tribe.members.length,
                  itemBuilder: (context, index) {
                    final member = widget.tribe.members[index];
                    final isChief = widget.tribe.chief.id == member.id;
                    final isModerator =
                        widget.tribe.moderators.any((mod) => mod.id == member.id);

                    return Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage:
                                  NetworkImage(member.profile.photos.first),
                            ),
                            if (isChief || isModerator)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: isChief
                                        ? Colors.amber
                                        : theme.colorScheme.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.scaffoldBackgroundColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    isChief ? Icons.star : Icons.shield,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          member.profile.name,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: isMember
          ? FloatingActionButton(
              onPressed: () {
                // TODO: Show create event/vote dialog
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
