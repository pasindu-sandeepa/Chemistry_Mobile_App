import '../entities/statistics_entity.dart';
import '../repositories/statistics_repository.dart';

class GetUserStatisticsUseCase {
  final StatisticsRepository repository;

  GetUserStatisticsUseCase(this.repository);

  Future<StatisticsEntity> execute() async {
    return await repository.getUserStatistics();
  }
}