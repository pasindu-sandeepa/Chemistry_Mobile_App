import '../repositories/statistics_repository.dart';

class GetUserStatisticsUseCase {
  final StatisticsRepository repository;

  GetUserStatisticsUseCase(this.repository);

  Future<Map<String, dynamic>> execute() async {
    final quizScores = await repository.getQuizScores();
    final completedPaths = await repository.getCompletedLearningPathsCount();
    return {
      'quizScores': quizScores,
      'completedPaths': completedPaths,
    };
  }
}
