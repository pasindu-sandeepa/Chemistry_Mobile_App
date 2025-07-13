import '../entities/element_entity.dart';

abstract class ElementRepository {
  Future<List<ElementEntity>> getElements();
  Future<void> saveFavoriteElement(ElementEntity element);
  Future<List<ElementEntity>> getFavorites();
}