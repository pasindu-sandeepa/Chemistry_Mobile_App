import 'package:flutter/material.dart';
import 'src/core/utils/dependency_injection.dart';
import 'src/presentation/screens/splash_screen.dart';

void main() {
  setupDependencies(); // Initialize dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Periodic Table App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}
