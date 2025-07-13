import '../entities/learning_path_entity.dart';

abstract class LearningPathRepository {
  Future<List<LearningPathEntity>> getLearningPaths();
  Future<void> updateLearningPathProgress(int id, bool isCompleted);
}
