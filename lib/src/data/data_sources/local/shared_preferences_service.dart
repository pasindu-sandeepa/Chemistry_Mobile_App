import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/element_model.dart';

class SharedPreferencesService {
  static const String _favoritesKey = 'favorite_elements';

  Future<void> saveFavoriteElement(ElementModel element) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.add(element);
    final encodedFavorites =
        favorites.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_favoritesKey, encodedFavorites);
  }

  Future<List<ElementModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedFavorites = prefs.getStringList(_favoritesKey) ?? [];
    return encodedFavorites
        .map((e) => ElementModel.fromJson(jsonDecode(e)))
        .toList();
  }
}
