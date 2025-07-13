import '../entities/element_entity.dart';
import '../repositories/element_repository.dart';

class GetFavoriteElementsUseCase {
  final ElementRepository repository;

  GetFavoriteElementsUseCase(this.repository);

  Future<List<ElementEntity>> execute() async {
    return await repository.getFavorites();
  }
}
