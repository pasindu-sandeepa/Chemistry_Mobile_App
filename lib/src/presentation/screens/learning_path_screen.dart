import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/dependency_injection.dart';
import '../../domain/use_cases/get_learning_path_use_case.dart';
import '../../domain/use_cases/update_user_progress_use_case.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_indicator.dart';

final learningPathProvider = FutureProvider<List<dynamic>>((ref) async {
  final getLearningPathUseCase = getIt<GetLearningPathUseCase>();
  return await getLearningPathUseCase.execute();
});

class LearningPathScreen extends ConsumerWidget {
  const LearningPathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final learningPathsAsync = ref.watch(learningPathProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        titleKey: 'learningPathScreenTitle',
      ),
      body: learningPathsAsync.when(
        data: (learningPaths) {
          if (learningPaths.isEmpty) {
            return const Center(child: Text('No learning paths available'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: learningPaths.length,
            itemBuilder: (context, index) {
              final path = learningPaths[index];
              return ListTile(
                title: Text(path.title),
                subtitle: Text(path.description),
                trailing: Checkbox(
                  value: path.isCompleted,
                  onChanged: (value) async {
                    final updateUserProgressUseCase =
                        getIt<UpdateUserProgressUseCase>();
                    await updateUserProgressUseCase.execute(
                        path.id, value ?? false);
                    ref.refresh(learningPathProvider);
                  },
                ),
              );
            },
          );
        },
        loading: () => const LoadingIndicator(),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
