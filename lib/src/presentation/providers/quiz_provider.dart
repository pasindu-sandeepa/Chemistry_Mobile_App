import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/quiz_entity.dart';
import '../../domain/use_cases/get_quiz_questions_use_case.dart';
import '../../core/utils/dependency_injection.dart';
import '../../data/data_sources/local/database_service.dart';

final quizProvider = FutureProvider<List<QuizEntity>>((ref) async {
  final getQuizQuestionsUseCase = getIt<GetQuizQuestionsUseCase>();
  return await getQuizQuestionsUseCase.execute();
});

final quizStateProvider = StateProvider<QuizState>((ref) => QuizState());

class QuizState {
  final int currentQuestionIndex;
  final int score;
  final Map<int, int?> selectedAnswers;

  QuizState({
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.selectedAnswers = const {},
  });

  QuizState copyWith({
    int? currentQuestionIndex,
    int? score,
    Map<int, int?>? selectedAnswers,
  }) {
    return QuizState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }

  Future<void> saveScore() async {
    final databaseService = getIt<DatabaseService>();
    await databaseService.saveQuizScore(score);
  }
}
