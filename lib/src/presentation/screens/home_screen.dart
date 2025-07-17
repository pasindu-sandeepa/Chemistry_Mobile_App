import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Periodic Table App'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const Center(
        child: Text(
          'Welcome to the Periodic Table App!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}