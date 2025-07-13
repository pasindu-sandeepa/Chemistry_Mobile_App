import '../../domain/entities/quiz_entity.dart';

class QuizModel extends QuizEntity {
  QuizModel({
    required int id,
    required String question,
    required List<String> options,
    required int correctAnswerIndex,
  }) : super(
          id: id,
          question: question,
          options: options,
          correctAnswerIndex: correctAnswerIndex,
        );

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }
}