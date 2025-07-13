import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);

class SettingsState {
  final ThemeMode themeMode;
  final String language;

  SettingsState({required this.themeMode, required this.language});

  SettingsState copyWith({ThemeMode? themeMode, String? language}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
      : super(SettingsState(themeMode: ThemeMode.system, language: 'en')) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme') ?? 'system';
    final language = prefs.getString('language') ?? 'en';
    state = SettingsState(
      themeMode: theme == 'dark'
          ? ThemeMode.dark
          : theme == 'light'
              ? ThemeMode.light
              : ThemeMode.system,
      language: language,
    );
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'theme',
        themeMode == ThemeMode.dark
            ? 'dark'
            : themeMode == ThemeMode.light
                ? 'light'
                : 'system');
    state = state.copyWith(themeMode: themeMode);
  }

  Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    state = state.copyWith(language: language);
  }
}