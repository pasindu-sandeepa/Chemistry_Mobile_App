import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/dependency_injection.dart';
import '../../domain/entities/element_entity.dart';
import '../../domain/use_cases/save_favorite_element_use_case.dart';
import '../widgets/custom_app_bar.dart';
import '../providers/element_provider.dart';

class ElementDetailsScreen extends ConsumerWidget {
  final ElementEntity element;

  const ElementDetailsScreen({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteElementsAsync = ref.watch(favoriteElementsProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: element.name,
        actions: [
          favoriteElementsAsync.when(
            data: (favorites) {
              final isFavorite = favorites.any(
                (e) => e.atomicNumber == element.atomicNumber,
              );
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () async {
                  final saveFavoriteUseCase = getIt<SaveFavoriteElementUseCase>();
                  await saveFavoriteUseCase.execute(element);
                  ref.invalidate(favoriteElementsProvider);
                },
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (e, _) => Icon(Icons.error, color: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Atomic Number: ${element.atomicNumber}',
                style: const TextStyle(fontSize: 18)),
            Text('Symbol: ${element.symbol}',
                style: const TextStyle(fontSize: 18)),
            Text('Atomic Mass: ${element.atomicMass}',
                style: const TextStyle(fontSize: 18)),
            Text('Category: ${element.category}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}