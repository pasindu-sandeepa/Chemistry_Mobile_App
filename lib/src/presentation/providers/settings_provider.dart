import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data_sources/local/shared_preferences_service.dart';
import '../../core/utils/dependency_injection.dart';
import 'theme_provider.dart';

// Settings state
class SettingsState {
  final bool isDarkTheme;
  SettingsState({required this.isDarkTheme});

  SettingsState copyWith({bool? isDarkTheme}) =>
      SettingsState(isDarkTheme: isDarkTheme ?? this.isDarkTheme);
}

// Notifier
class SettingsNotifier extends StateNotifier<SettingsState> {
  final SharedPreferencesService _sharedPreferencesService;
  SettingsNotifier(this._sharedPreferencesService)
      : super(SettingsState(isDarkTheme: false));

  Future<void> loadTheme() async {
    final theme = await _sharedPreferencesService.getTheme();
    state = state.copyWith(isDarkTheme: theme == 'dark');
  }

  Future<void> toggleTheme(bool isDarkTheme, WidgetRef ref) async {
    await _sharedPreferencesService.setTheme(isDarkTheme ? 'dark' : 'light');
    state = state.copyWith(isDarkTheme: isDarkTheme);
    ref.read(themeModeProvider.notifier).state =
        isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }
}

// Provider
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final prefs = getIt<SharedPreferencesService>();
  final notifier = SettingsNotifier(prefs);
  notifier.loadTheme();
  return notifier;
});