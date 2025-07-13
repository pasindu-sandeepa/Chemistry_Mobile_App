import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.textColor, fontSize: 20),
      bodyLarge: TextStyle(color: AppColors.textColor, fontSize: 16),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}