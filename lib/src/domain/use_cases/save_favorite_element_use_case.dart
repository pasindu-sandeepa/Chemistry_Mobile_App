import '../entities/element_entity.dart';
import '../repositories/element_repository.dart';

class SaveFavoriteElementUseCase {
  final ElementRepository repository;

  SaveFavoriteElementUseCase(this.repository);

  Future<void> execute(ElementEntity element) async {
    await repository.saveFavoriteElement(element);
  }
}
