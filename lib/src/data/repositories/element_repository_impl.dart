import '../../domain/entities/element_entity.dart';
import '../../domain/repositories/element_repository.dart';
import '../data_sources/remote/element_api_service.dart';
import '../data_sources/local/shared_preferences_service.dart';
import '../models/element_model.dart'; // Import ElementModel

class ElementRepositoryImpl implements ElementRepository {
  final ElementApiService apiService;
  final SharedPreferencesService sharedPreferencesService;

  ElementRepositoryImpl(this.apiService, this.sharedPreferencesService);

  @override
  Future<List<ElementEntity>> getElements() async {
    final elements = await apiService.getElements();
    return elements; // ElementModel extends ElementEntity
  }

  @override
  Future<void> saveFavoriteElement(ElementEntity element) async {
    if (element is ElementModel) {
      await sharedPreferencesService.saveFavoriteElement(element);
    } else {
      throw Exception('Element must be of type ElementModel');
    }
  }

  @override
  Future<List<ElementEntity>> getFavorites() async {
    final favorites = await sharedPreferencesService.getFavorites();
    return favorites; // ElementModel extends ElementEntity
  }
}