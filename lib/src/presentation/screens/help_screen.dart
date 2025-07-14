import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/custom_app_bar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Help & User Guide'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Periodic Table App - User Guide',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Welcome to the Periodic Table App! This guide will help you navigate and make the most of the app’s features.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildSection(
                title: '1. Explore Periodic Table',
                content: 'Tap the "Explore Periodic Table" button on the Home Screen to view all elements in a grid layout. Click on any element to see detailed information such as atomic number, symbol, and properties.',
              ),
              _buildSection(
                title: '2. View Favorites',
                content: 'Save your favorite elements by tapping the heart icon on the element details page. Access them anytime from the "View Favorites" section on the Home Screen.',
              ),
              _buildSection(
                title: '3. Search Elements',
                content: 'Use the "Search Elements" feature to find elements by name, symbol, atomic number, or category. Type your query in the search bar to filter results instantly.',
              ),
              _buildSection(
                title: '4. Take Quiz',
                content: 'Test your knowledge with the "Take Quiz" feature. Answer multiple-choice questions about elements and track your score. Scores are saved for review in the Statistics section.',
              ),
              _buildSection(
                title: '5. Learning Path',
                content: 'Follow structured lessons in the "Learning Path" section to learn about atomic structure, chemical bonds, and periodic trends. Mark lessons as completed to track your progress.',
              ),
              _buildSection(
                title: '6. Settings',
                content: 'Customize your experience in the "Settings" section. Toggle between light and dark themes or enable/disable notifications for learning reminders.',
              ),
              _buildSection(
                title: '7. View Statistics',
                content: 'Check your progress in the "View Statistics" section. View your quiz scores in a bar chart and learning path completion in a pie chart.',
              ),
              _buildSection(
                title: '8. About',
                content: 'Learn more about the app, including version details and developer information, in the "About" section.',
              ),
              const SizedBox(height: 16),
              const Text(
                'Need More Help?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Contact: your.email@example.com',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
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