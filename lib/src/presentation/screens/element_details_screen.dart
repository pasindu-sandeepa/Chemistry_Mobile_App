import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/element_entity.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/element_card.dart';
import '../../domain/use_cases/save_favorite_element_use_case.dart';
import '../../core/utils/dependency_injection.dart';

class ElementDetailsScreen extends ConsumerWidget {
  final ElementEntity element;

  const ElementDetailsScreen({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(element.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              final saveFavoriteUseCase = getIt<SaveFavoriteElementUseCase>();
              saveFavoriteUseCase.execute(element);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${element.name} added to favorites')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElementCard(element: element),
            const SizedBox(height: 16),
            Text(
              'Atomic Number: ${element.atomicNumber}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Atomic Mass: ${element.atomicMass}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Category: ${element.category}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}