import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/quiz_model.dart';

class QuizApiService {
  Future<List<QuizModel>> getQuizQuestions() async {
    final String response = await rootBundle.loadString('assets/quiz_questions.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => QuizModel.fromJson(json)).toList();
  }
}