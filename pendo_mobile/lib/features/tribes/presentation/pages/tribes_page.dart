import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pendo_mobile/core/navigation/route_names.dart';
import 'package:pendo_mobile/features/tribes/data/models/tribe_model.dart';
import 'package:pendo_mobile/features/tribes/presentation/bloc/tribes_bloc.dart';
import 'package:pendo_mobile/features/tribes/presentation/bloc/tribes_event.dart';
import 'package:pendo_mobile/features/tribes/presentation/bloc/tribes_state.dart';
import 'package:pendo_mobile/features/tribes/presentation/widgets/tribe_card.dart';

class TribesPage extends StatefulWidget {
  const TribesPage({super.key});

  @override
  State<TribesPage> createState() => _TribesPageState();
}

class _TribesPageState extends State<TribesPage> {
  final _scrollController = ScrollController();
  List<TribeModel> _tribes = [];
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadTribes();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _loadTribes();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadTribes() {
    if (!_isLoading) {
      context.read<TribesBloc>().add(
            LoadTribesEvent(
              page: (_tribes.length ~/ 20) + 1,
              limit: 20,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tribes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, Routes.createTribe);
            },
          ),
        ],
      ),
      body: BlocConsumer<TribesBloc, TribesState>(
        listener: (context, state) {
          if (state is TribesLoaded) {
            setState(() {
              _tribes = state.tribes;
              _isLoading = false;
              _hasMore = state.hasMore;
            });
          } else if (state is TribeJoined) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully joined the tribe!')),
            );
          } else if (state is TribesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (_tribes.isEmpty && state is TribesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_tribes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.group_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tribes found',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create or join a tribe to get started',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.createTribe);
                    },
                    child: const Text('Create Tribe'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _tribes.clear();
              _loadTribes();
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _tribes.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _tribes.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final tribe = _tribes[index];
                final isMember = tribe.members
                    .any((user) => user.id.toString() == 'current_user_id'); // TODO: Get from auth

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TribeCard(
                    tribe: tribe,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.tribeDetails,
                        arguments: tribe,
                      );
                    },
                    onJoin: isMember
                        ? null
                        : () {
                            context
                                .read<TribesBloc>()
                                .add(JoinTribeEvent(tribe.id));
                          },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
