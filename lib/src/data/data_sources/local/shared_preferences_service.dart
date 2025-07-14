import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/element_model.dart';

class SharedPreferencesService {
  static const String _favoritesKey = 'favorite_elements';
  static const String _themeKey = 'is_dark_theme'; // legacy bool
  static const String _themeModeKey = 'theme_mode'; // new string key
  static const String _notificationsKey = 'notifications_enabled';

  // --- Favorite Elements ---
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

  // --- Theme (legacy, bool) ---
  Future<bool> getThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }

  Future<void> setThemePreference(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkTheme);
  }

  // --- Theme (new, string: 'light', 'dark', 'system') ---
  Future<String> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeModeKey) ?? 'system';
  }

  Future<void> setTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, theme);
  }

  // --- Notifications ---
  Future<bool> getNotificationsPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? true;
  }

  Future<void> setNotificationsPreference(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, enabled);
  }
}