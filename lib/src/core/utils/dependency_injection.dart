import 'package:get_it/get_it.dart';
import '../../data/data_sources/remote/element_api_service.dart';
import '../../data/data_sources/remote/quiz_api_service.dart';
import '../../data/data_sources/local/shared_preferences_service.dart';
import '../../data/data_sources/local/database_service.dart';
import '../../data/data_sources/local/notification_service.dart';
import '../../data/repositories/element_repository_impl.dart';
import '../../data/repositories/quiz_repository_impl.dart';
import '../../data/repositories/learning_path_repository_impl.dart';
import '../../data/repositories/statistics_repository_impl.dart';
import '../../domain/repositories/element_repository.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../domain/repositories/learning_path_repository.dart';
import '../../domain/repositories/statistics_repository.dart';
import '../../domain/use_cases/get_elements_use_case.dart';
import '../../domain/use_cases/save_favorite_element_use_case.dart';
import '../../domain/use_cases/get_favorite_elements_use_case.dart';
import '../../domain/use_cases/search_elements_use_case.dart';
import '../../domain/use_cases/get_quiz_questions_use_case.dart';
import '../../domain/use_cases/get_learning_path_use_case.dart';
import '../../domain/use_cases/update_user_progress_use_case.dart';
import '../../domain/use_cases/get_user_statistics_use_case.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Register services
  getIt.registerSingleton<ElementApiService>(ElementApiService());
  getIt.registerSingleton<QuizApiService>(QuizApiService());
  getIt.registerSingleton<SharedPreferencesService>(SharedPreferencesService());
  getIt.registerSingleton<DatabaseService>(DatabaseService());
  getIt.registerSingleton<NotificationService>(NotificationService());

  // Register repositories
  getIt.registerSingleton<ElementRepository>(
    ElementRepositoryImpl(
      getIt<ElementApiService>(),
      getIt<SharedPreferencesService>(),
    ),
  );
  getIt.registerSingleton<QuizRepository>(
    QuizRepositoryImpl(getIt<QuizApiService>()),
  );
  getIt.registerSingleton<LearningPathRepository>(
    LearningPathRepositoryImpl(getIt<DatabaseService>()),
  );
  getIt.registerSingleton<StatisticsRepository>(
    StatisticsRepositoryImpl(getIt<DatabaseService>()),
  );

  // Register use cases
  getIt.registerSingleton<GetElementsUseCase>(
    GetElementsUseCase(getIt<ElementRepository>()),
  );
  getIt.registerSingleton<SaveFavoriteElementUseCase>(
    SaveFavoriteElementUseCase(getIt<ElementRepository>()),
  );
  getIt.registerSingleton<GetFavoriteElementsUseCase>(
    GetFavoriteElementsUseCase(getIt<ElementRepository>()),
  );
  getIt.registerSingleton<SearchElementsUseCase>(
    SearchElementsUseCase(getIt<ElementRepository>()),
  );
  getIt.registerSingleton<GetQuizQuestionsUseCase>(
    GetQuizQuestionsUseCase(getIt<QuizRepository>()),
  );
  getIt.registerSingleton<GetLearningPathUseCase>(
    GetLearningPathUseCase(getIt<LearningPathRepository>()),
  );
  getIt.registerSingleton<UpdateUserProgressUseCase>(
    UpdateUserProgressUseCase(getIt<LearningPathRepository>()),
  );
  getIt.registerSingleton<GetUserStatisticsUseCase>(
    GetUserStatisticsUseCase(getIt<StatisticsRepository>()),
  );
}