import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/element_entity.dart';
import '../../domain/use_cases/get_elements_use_case.dart';
import '../../core/utils/dependency_injection.dart';

final elementProvider = FutureProvider<List<ElementEntity>>((ref) async {
  final getElementsUseCase = getIt<GetElementsUseCase>();
  return await getElementsUseCase.execute();
});
