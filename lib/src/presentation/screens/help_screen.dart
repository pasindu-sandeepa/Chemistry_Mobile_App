import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/custom_app_bar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const CustomAppBar(
        titleKey: 'helpScreenTitle',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              localizations.helpScreenTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.helpIntroduction,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: localizations.helpExplorePeriodicTable,
              content: localizations.helpExplorePeriodicTableDescription,
            ),
            _buildSection(
              context,
              title: localizations.helpFavorites,
              content: localizations.helpFavoritesDescription,
            ),
            _buildSection(
              context,
              title: localizations.helpSearch,
              content: localizations.helpSearchDescription,
            ),
            _buildSection(
              context,
              title: localizations.helpQuiz,
              content: localizations.helpQuizDescription,
            ),
            _buildSection(
              context,
              title: localizations.helpLearningPath,
              content: localizations.helpLearningPathDescription,
            ),
            _buildSection(
              context,
              title: localizations.helpSettings,
              content: localizations.helpSettingsDescription,
            ),
            _buildSection(
              context,
              title: localizations.helpStatistics,
              content: localizations.helpStatisticsDescription,
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact Support',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Email: support@periodictableapp.com',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Website: www.periodictableapp.com',
              style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
