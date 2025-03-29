import 'package:equatable/equatable.dart';
import '../../../user/domain/models/user.dart';

class Recommendation extends Equatable {
  final User user;
  final double compatibility;
  final double activityScore;
  final double popularityScore;

  const Recommendation({
    required this.user,
    required this.compatibility,
    required this.activityScore,
    required this.popularityScore,
  });

  @override
  List<Object?> get props => [
        user,
        compatibility,
        activityScore,
        popularityScore,
      ];

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      user: User.fromJson(json['user']),
      compatibility: json['compatibility'].toDouble(),
      activityScore: json['activity_score'].toDouble(),
      popularityScore: json['popularity_score'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'compatibility': compatibility,
      'activity_score': activityScore,
      'popularity_score': popularityScore,
    };
  }

  // Общий скор рекомендации
  double get totalScore {
    return 0.6 * compatibility + 0.2 * activityScore + 0.2 * popularityScore;
  }
}
