import '../../domain/repositories/statistics_repository.dart';
import '../data_sources/local/database_service.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final DatabaseService databaseService;

  StatisticsRepositoryImpl(this.databaseService);

  @override
  Future<List<Map<String, dynamic>>> getQuizScores() async {
    return await databaseService.getQuizScores();
  }

  @override
  Future<int> getCompletedLearningPathsCount() async {
    return await databaseService.getCompletedLearningPathsCount();
  }
}
