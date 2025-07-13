import '../entities/element_entity.dart';
import '../repositories/element_repository.dart';

class GetElementsUseCase {
  final ElementRepository repository;

  GetElementsUseCase(this.repository);

  Future<List<ElementEntity>> execute() async {
    return await repository.getElements();
  }
}