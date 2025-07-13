import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/dependency_injection.dart';
import '../../data/data_sources/local/notification_service.dart';
import '../widgets/custom_app_bar.dart';
import 'element_list_screen.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';
import 'quiz_screen.dart';
import 'learning_path_screen.dart';
import 'settings_screen.dart';
import 'statistics_screen.dart';
import 'about_screen.dart';
import 'help_screen.dart';
import 'offline_mode_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationService = getIt<NotificationService>();

    return Scaffold(
      appBar: const CustomAppBar(
        titleKey: AppStrings.homeScreenTitle,
        showBackButton: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppStrings.homeScreenTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const SpinKitCubeGrid(color: AppColors.primaryColor),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ElementListScreen()),
                );
              },
              child: const Text('Explore Periodic Table'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoritesScreen()),
                );
              },
              child: const Text('View Favorites'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: const Text('Search Elements'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await notificationService.showQuizReminder(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()),
                );
              },
              child: const Text('Take Quiz'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await notificationService.showLearningPathReminder(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LearningPathScreen()),
                );
              },
              child: const Text('Learning Path'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
              child: const Text('Settings'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StatisticsScreen()),
                );
              },
              child: const Text('Statistics'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
              child: const Text('About'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()),
                );
              },
              child: const Text('Help'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OfflineModeScreen()),
                );
              },
              child: const Text('Offline Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
