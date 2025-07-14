import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/dependency_injection.dart';
import '../../domain/use_cases/update_user_progress_use_case.dart';
import '../providers/learning_path_provider.dart';
import '../widgets/custom_app_bar.dart';

class LearningPathScreen extends ConsumerWidget {
  const LearningPathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final learningPathsAsync = ref.watch(learningPathProvider);
    final learningPathState = ref.watch(learningPathStateProvider);
    final learningPathStateNotifier = ref.read(learningPathStateProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Learning Path'),
      body: learningPathsAsync.when(
        data: (paths) {
          if (paths.isEmpty) {
            return const Center(child: Text('No learning paths available'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: paths.length,
            itemBuilder: (context, index) {
              final path = paths[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    path.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(path.description),
                  trailing: Checkbox(
                    value: path.isCompleted,
                    onChanged: (value) {
                      final updateProgressUseCase = getIt<UpdateUserProgressUseCase>();
                      updateProgressUseCase.execute(path.id, value!);
                      learningPathStateNotifier.state = learningPathState.copyWith(
                        completedPaths: {
                          ...learningPathState.completedPaths,
                          path.id: value,
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}