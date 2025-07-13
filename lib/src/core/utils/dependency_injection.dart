import 'package:get_it/get_it.dart';
import '../../data/data_sources/remote/element_api_service.dart';
import '../../data/repositories/element_repository_impl.dart';
import '../../domain/repositories/element_repository.dart';
import '../../domain/use_cases/get_elements_use_case.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Register services
  getIt.registerSingleton<ElementApiService>(ElementApiService());
  
  // Register repositories
  getIt.registerSingleton<ElementRepository>(ElementRepositoryImpl(getIt<ElementApiService>()));
  
  // Register use cases
  getIt.registerSingleton<GetElementsUseCase>(GetElementsUseCase(getIt<ElementRepository>()));
}