import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/element_card.dart';
import '../providers/element_provider.dart';
import '../widgets/custom_app_bar.dart';
import 'element_details_screen.dart';

class ElementListScreen extends ConsumerWidget {
  const ElementListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elementsAsync = ref.watch(elementProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Periodic Table'),
      body: elementsAsync.when(
        data: (elements) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: elements.length,
            itemBuilder: (context, index) {
              final element = elements[index];
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
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}