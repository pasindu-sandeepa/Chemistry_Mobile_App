import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/dependency_injection.dart';
import '../../domain/use_cases/search_elements_use_case.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/element_card.dart';
import '../widgets/loading_indicator.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final searchResultsProvider = FutureProvider<List<dynamic>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final searchElementsUseCase = getIt<SearchElementsUseCase>();
  return await searchElementsUseCase.execute(query);
});

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResultsAsync = ref.watch(searchResultsProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final searchQueryNotifier = ref.read(searchQueryProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(
        titleKey: 'searchScreenTitle',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                searchQueryNotifier.state = value;
              },
              decoration: const InputDecoration(
                hintText: 'Search elements...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: searchResultsAsync.when(
              data: (elements) {
                if (elements.isEmpty && searchQuery.isNotEmpty) {
                  return const Center(child: Text('No elements found'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
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
              loading: () => const LoadingIndicator(),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
