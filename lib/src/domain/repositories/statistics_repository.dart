import '../entities/statistics_entity.dart';

abstract class StatisticsRepository {
  Future<StatisticsEntity> getUserStatistics();
}
