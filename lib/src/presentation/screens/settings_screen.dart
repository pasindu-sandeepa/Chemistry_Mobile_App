import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/dependency_injection.dart';
import '../../data/data_sources/local/shared_preferences_service.dart';
import '../widgets/custom_app_bar.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final themeModeNotifier = ref.read(themeModeProvider.notifier);
    final localeNotifier = ref.read(localeProvider.notifier);
    final sharedPreferencesService = getIt<SharedPreferencesService>();

    return Scaffold(
      appBar: const CustomAppBar(
        titleKey: 'settingsScreenTitle',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.theme,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text(localizations.lightTheme),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: themeMode,
                onChanged: (value) {
                  themeModeNotifier.state = value!;
                  sharedPreferencesService.saveTheme(value.name);
                },
              ),
            ),
            ListTile(
              title: Text(localizations.darkTheme),
              leading: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: themeMode,
                onChanged: (value) {
                  themeModeNotifier.state = value!;
                  sharedPreferencesService.saveTheme(value.name);
                },
              ),
            ),
            ListTile(
              title: Text(localizations.systemTheme),
              leading: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: themeMode,
                onChanged: (value) {
                  themeModeNotifier.state = value!;
                  sharedPreferencesService.saveTheme(value.name);
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.language,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('English'),
              leading: Radio<Locale>(
                value: const Locale('en'),
                groupValue: locale,
                onChanged: (value) {
                  localeNotifier.state = value!;
                  sharedPreferencesService.saveLanguage(value.languageCode);
                },
              ),
            ),
            ListTile(
              title: const Text('සිංහල'),
              leading: Radio<Locale>(
                value: const Locale('si'),
                groupValue: locale,
                onChanged: (value) {
                  localeNotifier.state = value!;
                  sharedPreferencesService.saveLanguage(value.languageCode);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
