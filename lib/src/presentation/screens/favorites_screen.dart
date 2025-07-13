import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/dependency_injection.dart';
import '../../domain/use_cases/get_favorite_elements_use_case.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/element_card.dart';
import '../widgets/loading_indicator.dart';

final favoritesProvider = FutureProvider<List<dynamic>>((ref) async {
  final getFavoriteElementsUseCase = getIt<GetFavoriteElementsUseCase>();
  return await getFavoriteElementsUseCase.execute();
});

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        titleKey: 'favoritesScreenTitle',
      ),
      body: favoritesAsync.when(
        data: (favorites) {
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorites added'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final element = favorites[index];
              return ElementCard(
                element: element,
                onTap: () {
                  // Navigate to element detail screen (to be implemented)
                },
              );
            },
          );
        },
        loading: () => const LoadingIndicator(),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}