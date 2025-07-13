import '../../domain/entities/element_entity.dart';
import '../../domain/repositories/element_repository.dart';
import '../data_sources/remote/element_api_service.dart';

class ElementRepositoryImpl implements ElementRepository {
  final ElementApiService apiService;

  ElementRepositoryImpl(this.apiService);

  @override
  Future<List<ElementEntity>> getElements() async {
    final elements = await apiService.getElements();
    return elements; // ElementModel extends ElementEntity
  }
}
