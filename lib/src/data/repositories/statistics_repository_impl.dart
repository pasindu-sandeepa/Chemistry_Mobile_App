import '../../domain/entities/statistics_entity.dart';
import '../../domain/repositories/statistics_repository.dart';
import '../data_sources/local/database_service.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final DatabaseService databaseService;

  StatisticsRepositoryImpl(this.databaseService);

  @override
  Future<StatisticsEntity> getUserStatistics() async {
    final quizScores = await databaseService.getQuizScores();
    final completedPaths = await databaseService.getLearningPaths();
    final completedCount = completedPaths.where((path) => path.isCompleted).length;
    return StatisticsEntity(
      quizScores: quizScores,
      learningPathCompletion: completedCount,
      totalLearningPaths: completedPaths.length,
    );
  }
}