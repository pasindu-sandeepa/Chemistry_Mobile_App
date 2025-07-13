import 'package:flutter/material.dart';
import '../../domain/entities/quiz_entity.dart';
import '../../core/constants/app_colors.dart';

class QuizQuestionCard extends StatelessWidget {
  final QuizEntity question;
  final int? selectedAnswerIndex;
  final Function(int) onAnswerSelected;

  const QuizQuestionCard({
    Key? key,
    required this.question,
    required this.selectedAnswerIndex,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return RadioListTile<int>(
                title: Text(option),
                value: index,
                groupValue: selectedAnswerIndex,
                onChanged: (value) => onAnswerSelected(value!),
                activeColor: AppColors.primaryColor,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
