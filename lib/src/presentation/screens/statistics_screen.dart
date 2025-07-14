import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/dependency_injection.dart';
import '../../domain/use_cases/get_user_statistics_use_case.dart';
import '../widgets/custom_app_bar.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getStatisticsUseCase = getIt<GetUserStatisticsUseCase>();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Statistics'),
      body: FutureBuilder(
        future: getStatisticsUseCase.execute(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No statistics available'));
          }
          final stats = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quiz Scores',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barGroups: stats.quizScores.asMap().entries.map((entry) {
                        final index = entry.key;
                        final score = entry.value.toDouble();
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: score,
                              color: AppColors.primaryColor,
                              width: 16,
                            ),
                          ],
                        );
                      }).toList(),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) => Text('Quiz ${value.toInt() + 1}'),
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Learning Path Completion',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: stats.learningPathCompletion.toDouble(),
                          color: AppColors.primaryColor,
                          title: '${stats.learningPathCompletion}',
                          radius: 80,
                        ),
                        PieChartSectionData(
                          value: (stats.totalLearningPaths - stats.learningPathCompletion).toDouble(),
                          color: Colors.grey,
                          title: '${stats.totalLearningPaths - stats.learningPathCompletion}',
                          radius: 80,
                        ),
                      ],
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Completed: ${stats.learningPathCompletion}/${stats.totalLearningPaths}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}