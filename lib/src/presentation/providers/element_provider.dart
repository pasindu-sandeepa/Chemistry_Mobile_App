import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/dependency_injection.dart';
import '../../domain/entities/element_entity.dart';
import '../../domain/use_cases/get_elements_use_case.dart';
import '../../domain/use_cases/get_favorite_elements_use_case.dart';

// Provider for all elements
final elementProvider = FutureProvider<List<ElementEntity>>((ref) async {
  final useCase = getIt<GetElementsUseCase>();
  return await useCase.execute();
});

// Provider for favorite elements
final favoriteElementsProvider = FutureProvider<List<ElementEntity>>((ref) async {
  final useCase = getIt<GetFavoriteElementsUseCase>();
  return await useCase.execute();
});