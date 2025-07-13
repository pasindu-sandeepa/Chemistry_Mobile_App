import '../entities/quiz_entity.dart';
import '../repositories/quiz_repository.dart';

class GetQuizQuestionsUseCase {
  final QuizRepository repository;

  GetQuizQuestionsUseCase(this.repository);

  Future<List<QuizEntity>> execute() async {
    return await repository.getQuizQuestions();
  }
}