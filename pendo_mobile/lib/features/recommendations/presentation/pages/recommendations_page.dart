import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/recommendations_bloc.dart';
import '../widgets/recommendation_card.dart';
import '../../domain/models/recommendation.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../../shared/widgets/error_view.dart';

class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage({Key? key}) : super(key: key);

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<RecommendationsBloc>().add(LoadRecommendations());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onLike(Recommendation recommendation) {
    context.read<RecommendationsBloc>().add(
          LikeRecommendation(recommendation.user.id),
        );
    _nextPage();
  }

  void _onPass(Recommendation recommendation) {
    context.read<RecommendationsBloc>().add(
          PassRecommendation(recommendation.user.id),
        );
    _nextPage();
  }

  void _nextPage() {
    if (_pageController.page != null) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Рекомендации'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              // Открыть настройки рекомендаций
            },
          ),
        ],
      ),
      body: BlocConsumer<RecommendationsBloc, RecommendationsState>(
        listener: (context, state) {
          if (state is RecommendationsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is RecommendationsLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state is RecommendationsError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<RecommendationsBloc>().add(LoadRecommendations());
              },
            );
          }

          if (state is RecommendationsLoaded) {
            if (state.recommendations.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Рекомендации закончились',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Загляните позже, скоро появятся новые профили',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<RecommendationsBloc>()
                            .add(LoadRecommendations());
                      },
                      child: const Text('Обновить'),
                    ),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                // Карточки рекомендаций
                PageView.builder(
                  controller: _pageController,
                  itemCount: state.recommendations.length,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                    
                    // Подгружаем новые рекомендации, когда близко к концу
                    if (page >= state.recommendations.length - 3) {
                      context
                          .read<RecommendationsBloc>()
                          .add(LoadMoreRecommendations());
                    }
                  },
                  itemBuilder: (context, index) {
                    final recommendation = state.recommendations[index];
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: RecommendationCard(
                        recommendation: recommendation,
                        onLike: () => _onLike(recommendation),
                        onPass: () => _onPass(recommendation),
                        onTap: () {
                          // Открыть детальный профиль
                          Navigator.pushNamed(
                            context,
                            '/profile',
                            arguments: recommendation.user,
                          );
                        },
                      ),
                    );
                  },
                ),

                // Индикатор прогресса
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LinearProgressIndicator(
                      value: (_currentPage + 1) / state.recommendations.length,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
