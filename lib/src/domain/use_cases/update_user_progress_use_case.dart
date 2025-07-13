import '../repositories/learning_path_repository.dart';

class UpdateUserProgressUseCase {
  final LearningPathRepository repository;

  UpdateUserProgressUseCase(this.repository);

  Future<void> execute(int id, bool isCompleted) async {
    await repository.updateLearningPathProgress(id, isCompleted);
  }
}
