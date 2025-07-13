import '../entities/element_entity.dart';
import '../repositories/element_repository.dart';

class SearchElementsUseCase {
  final ElementRepository repository;

  SearchElementsUseCase(this.repository);

  Future<List<ElementEntity>> execute(String query) async {
    final elements = await repository.getElements();
    return elements.where((element) {
      final queryLower = query.toLowerCase();
      return element.name.toLowerCase().contains(queryLower) ||
          element.symbol.toLowerCase().contains(queryLower) ||
          element.atomicNumber.toString().contains(queryLower) ||
          element.category.toLowerCase().contains(queryLower);
    }).toList();
  }
}
