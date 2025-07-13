import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/dependency_injection.dart';
import '../../domain/use_cases/get_user_statistics_use_case.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_indicator.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getUserStatisticsUseCase = getIt<GetUserStatisticsUseCase>();

    return Scaffold(
      appBar: const CustomAppBar(
        titleKey: 'statisticsScreenTitle',
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserStatisticsUseCase.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No statistics available'));
          }

          final stats = snapshot.data!;
          final quizScores = stats['quizScores'] as List<Map<String, dynamic>>;
          final completedPaths = stats['completedPaths'] as int;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quiz Scores',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                quizScores.isEmpty
                    ? const Text('No quiz scores recorded')
                    : Expanded(
                        child: ListView.builder(
                          itemCount: quizScores.length,
                          itemBuilder: (context, index) {
                            final score = quizScores[index];
                            return ListTile(
                              title: Text('Score: ${score['score']}'),
                              subtitle: Text('Date: ${score['timestamp']}'),
                            );
                          },
                        ),
                      ),
                const Divider(),
                const Text(
                  'Learning Paths',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Completed Learning Paths: $completedPaths'),
              ],
            ),
          );
        },
      ),
    );
  }
}
