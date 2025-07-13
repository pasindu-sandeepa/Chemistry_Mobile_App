import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/quiz_question_card.dart';
import '../widgets/loading_indicator.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizQuestionsAsync = ref.watch(quizProvider);
    final quizState = ref.watch(quizStateProvider);
    final quizStateNotifier = ref.read(quizStateProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(
        titleKey: 'quizScreenTitle',
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Score: ${quizState.score}'),
          ),
        ],
      ),
      body: quizQuestionsAsync.when(
        data: (questions) {
          if (questions.isEmpty) {
            return const Center(child: Text('No questions available'));
          }
          final currentQuestion = questions[quizState.currentQuestionIndex];
          return Column(
            children: [
              Expanded(
                child: QuizQuestionCard(
                  question: currentQuestion,
                  selectedAnswerIndex:
                      quizState.selectedAnswers[currentQuestion.id],
                  onAnswerSelected: (index) {
                    final isCorrect =
                        index == currentQuestion.correctAnswerIndex;
                    quizStateNotifier.state = quizState.copyWith(
                      selectedAnswers: {
                        ...quizState.selectedAnswers,
                        currentQuestion.id: index,
                      },
                      score: isCorrect ? quizState.score + 1 : quizState.score,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed:
                      quizState.currentQuestionIndex < questions.length - 1
                          ? () {
                              quizStateNotifier.state = quizState.copyWith(
                                currentQuestionIndex:
                                    quizState.currentQuestionIndex + 1,
                              );
                            }
                          : () async {
                              await quizState.saveScore();
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Quiz Completed'),
                                  content: Text(
                                      'Your score: ${quizState.score}/${questions.length}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        quizStateNotifier.state = QuizState();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Restart'),
                                    ),
                                  ],
                                ),
                              );
                            },
                  child: Text(
                      quizState.currentQuestionIndex < questions.length - 1
                          ? 'Next Question'
                          : 'Finish Quiz'),
                ),
              ),
            ],
          );
        },
        loading: () => const LoadingIndicator(),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
