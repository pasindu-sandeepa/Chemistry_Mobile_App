import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/dependency_injection.dart';
import '../../domain/use_cases/get_elements_use_case.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/element_card.dart';

final elementsProvider = FutureProvider<List<dynamic>>((ref) async {
  final getElementsUseCase = getIt<GetElementsUseCase>();
  return await getElementsUseCase.execute();
});

class ElementListScreen extends ConsumerWidget {
  const ElementListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elementsAsync = ref.watch(elementsProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        titleKey: 'elementListScreenTitle',
      ),
      body: elementsAsync.when(
        data: (elements) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: elements.length,
            itemBuilder: (context, index) {
              final element = elements[index];
              return ElementCard(
                element: element,
                onTap: () {
                  // Navigate to element detail screen (to be implemented)
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