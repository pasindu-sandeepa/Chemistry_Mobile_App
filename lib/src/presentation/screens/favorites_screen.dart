import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/element_provider.dart';
import '../widgets/element_card.dart';
import '../widgets/custom_app_bar.dart';
import 'element_details_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteElementsAsync = ref.watch(favoriteElementsProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Favorites'),
      body: favoriteElementsAsync.when(
        data: (favoriteElements) {
          if (favoriteElements.isEmpty) {
            return const Center(child: Text('No favorites added yet'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favoriteElements.length,
            itemBuilder: (context, index) {
              final element = favoriteElements[index];
              return ElementCard(
                element: element,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ElementDetailsScreen(element: element),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}