class QuizEntity {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizEntity({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}