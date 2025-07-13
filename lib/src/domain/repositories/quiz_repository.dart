import '../entities/quiz_entity.dart';

abstract class QuizRepository {
  Future<List<QuizEntity>> getQuizQuestions();
}