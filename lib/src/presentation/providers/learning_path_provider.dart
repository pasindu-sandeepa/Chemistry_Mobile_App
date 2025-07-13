import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/learning_path_entity.dart';
import '../../domain/use_cases/get_learning_path_use_case.dart';
import '../../domain/use_cases/update_user_progress_use_case.dart';
import '../../core/utils/dependency_injection.dart';

final learningPathProvider = FutureProvider<List<LearningPathEntity>>((ref) async {
  final getLearningPathUseCase = getIt<GetLearningPathUseCase>();
  return await getLearningPathUseCase.execute();
});

final learningPathStateProvider = StateProvider<LearningPathState>((ref) => LearningPathState());

class LearningPathState {
  final Map<int, bool> completedPaths;

  LearningPathState({this.completedPaths = const {}});

  LearningPathState copyWith({Map<int, bool>? completedPaths}) {
    return LearningPathState(
      completedPaths: completedPaths ?? this.completedPaths,
    );
  }
}