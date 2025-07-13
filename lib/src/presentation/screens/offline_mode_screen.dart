import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/dependency_injection.dart';
import '../../core/utils/network_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_indicator.dart';

final networkInfoProvider =
    Provider<NetworkInfo>((ref) => getIt<NetworkInfo>());

class OfflineModeScreen extends ConsumerWidget {
  const OfflineModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final networkInfo = ref.watch(networkInfoProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        titleKey: 'offlineModeScreenTitle',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<bool>(
          future: networkInfo.isConnected,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }

            final isConnected = snapshot.data ?? false;

            return ListView(
              children: [
                Text(
                  localizations.offlineModeScreenTitle,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  isConnected
                      ? localizations.offlineModeOnlineMessage
                      : localizations.offlineModeOfflineMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: isConnected ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  localizations.offlineModeInstructions,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  context,
                  title: localizations.offlineExplorePeriodicTable,
                  content: localizations.offlineExplorePeriodicTableDescription,
                ),
                _buildSection(
                  context,
                  title: localizations.offlineFavorites,
                  content: localizations.offlineFavoritesDescription,
                ),
                _buildSection(
                  context,
                  title: localizations.offlineLearningPath,
                  content: localizations.offlineLearningPathDescription,
                ),
                _buildSection(
                  context,
                  title: localizations.offlineLimitations,
                  content: localizations.offlineLimitationsDescription,
                ),
              ],
            );
          },
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
