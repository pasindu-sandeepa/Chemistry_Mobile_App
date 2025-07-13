abstract class StatisticsRepository {
  Future<List<Map<String, dynamic>>> getQuizScores();
  Future<int> getCompletedLearningPathsCount();
}
