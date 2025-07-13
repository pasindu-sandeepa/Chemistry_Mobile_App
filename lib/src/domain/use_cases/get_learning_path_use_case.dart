import '../entities/learning_path_entity.dart';
import '../repositories/learning_path_repository.dart';

class GetLearningPathUseCase {
  final LearningPathRepository repository;

  GetLearningPathUseCase(this.repository);

  Future<List<LearningPathEntity>> execute() async {
    return await repository.getLearningPaths();
  }
}
