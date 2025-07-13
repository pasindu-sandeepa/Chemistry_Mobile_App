import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/screens/home_screen.dart';
import 'src/core/constants/app_themes.dart';
import 'src/core/utils/dependency_injection.dart';

void main() {
  setupDependencies(); // Initialize dependencies
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Periodic Table App',
      theme: AppThemes.lightTheme,
      home: const HomeScreen(),
    );
  }
}