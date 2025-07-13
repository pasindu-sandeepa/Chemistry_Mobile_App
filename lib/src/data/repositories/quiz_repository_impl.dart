import '../../domain/entities/quiz_entity.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../data_sources/remote/quiz_api_service.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizApiService apiService;

  QuizRepositoryImpl(this.apiService);

  @override
  Future<List<QuizEntity>> getQuizQuestions() async {
    final questions = await apiService.getQuizQuestions();
    return questions; // QuizModel extends QuizEntity
  }
}