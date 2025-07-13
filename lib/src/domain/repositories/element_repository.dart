import '../entities/element_entity.dart';

abstract class ElementRepository {
  Future<List<ElementEntity>> getElements();
}