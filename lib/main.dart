import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/utils/dependency_injection.dart';
import 'src/data/data_sources/local/notification_service.dart';
import 'src/data/data_sources/local/shared_preferences_service.dart';
import 'src/presentation/screens/splash_screen.dart'; // <-- Import SplashScreen
import 'src/presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  final sharedPreferencesService = getIt<SharedPreferencesService>();
  final initialTheme = await sharedPreferencesService.getTheme();

  final notificationService = getIt<NotificationService>();
  await notificationService.initialize();

  runApp(
    ProviderScope(
      overrides: [
        themeModeProvider.overrideWith((ref) {
          return initialTheme == 'light'
              ? ThemeMode.light
              : initialTheme == 'dark'
                  ? ThemeMode.dark
                  : ThemeMode.system;
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Periodic Table',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      home: const SplashScreen(), // <-- Start with SplashScreen
    );
  }
}
