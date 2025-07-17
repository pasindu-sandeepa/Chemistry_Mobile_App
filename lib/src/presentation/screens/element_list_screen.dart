import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/element_entity.dart';
import '../providers/favorites_provider.dart';
import 'element_details_screen.dart';

// Provider for managing element list and search
class ElementListProvider extends StateNotifier<List<ElementEntity>> {
  ElementListProvider() : super([
    const ElementEntity(
      name: 'Hydrogen',
      symbol: 'H',
      atomicNumber: 1,
      atomicMass: 1.008,
      category: 'Nonmetal',
      description: 'The lightest element, used in fuel cells.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Helium',
      symbol: 'He',
      atomicNumber: 2,
      atomicMass: 4.002,
      category: 'Noble Gas',
      description: 'Used in balloons and cryogenics.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Lithium',
      symbol: 'Li',
      atomicNumber: 3,
      atomicMass: 6.941,
      category: 'Alkali Metal',
      description: 'Used in batteries and mood stabilizers.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Beryllium',
      symbol: 'Be',
      atomicNumber: 4,
      atomicMass: 9.012,
      category: 'Alkaline Earth Metal',
      description: 'Used in aerospace materials.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Boron',
      symbol: 'B',
      atomicNumber: 5,
      atomicMass: 10.811,
      category: 'Metalloid',
      description: 'Used in glass and detergents.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Carbon',
      symbol: 'C',
      atomicNumber: 6,
      atomicMass: 12.011,
      category: 'Nonmetal',
      description: 'The basis of all life forms.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Nitrogen',
      symbol: 'N',
      atomicNumber: 7,
      atomicMass: 14.007,
      category: 'Nonmetal',
      description: 'Makes up 78% of Earth\'s atmosphere.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Oxygen',
      symbol: 'O',
      atomicNumber: 8,
      atomicMass: 15.999,
      category: 'Nonmetal',
      description: 'Essential for respiration.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Fluorine',
      symbol: 'F',
      atomicNumber: 9,
      atomicMass: 18.998,
      category: 'Nonmetal',
      description: 'Most reactive element.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Neon',
      symbol: 'Ne',
      atomicNumber: 10,
      atomicMass: 20.180,
      category: 'Noble Gas',
      description: 'Used in neon signs.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Sodium',
      symbol: 'Na',
      atomicNumber: 11,
      atomicMass: 22.990,
      category: 'Alkali Metal',
      description: 'Found in salt.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Magnesium',
      symbol: 'Mg',
      atomicNumber: 12,
      atomicMass: 24.305,
      category: 'Alkaline Earth Metal',
      description: 'Used in lightweight alloys.',
      isFavorite: false,
    ),
    const ElementEntity(
      name: 'Aluminum',
      symbol: 'Al',
      atomicNumber: 13,
      atomicMass: 26.982,
      category: 'Metal',
      description: 'Used in aircraft and packaging.',
      isFavorite: false,
    ),
  ]);

  List<ElementEntity> _filteredElements = [];

  List<ElementEntity> get filteredElements => _filteredElements.isNotEmpty ? _filteredElements : state;

  void filterElements(String query) {
    if (query.isEmpty) {
      _filteredElements = state;
    } else {
      _filteredElements = state
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()) ||
              element.symbol.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    // Update state to trigger UI refresh
    state = [...state];
  }

  void resetFilter() {
    _filteredElements = state;
    state = [...state];
  }

  List<String> getSuggestions(String query) {
    if (query.isEmpty) {
      return [];
    }
    return state
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.symbol.toLowerCase().contains(query.toLowerCase()))
        .map((element) => element.name)
        .toList();
  }
}

final elementListProvider = StateNotifierProvider<ElementListProvider, List<ElementEntity>>((ref) {
  return ElementListProvider();
});

class ElementListScreen extends ConsumerStatefulWidget {
  const ElementListScreen({super.key});

  @override
  ElementListScreenState createState() => ElementListScreenState();
}

class ElementListScreenState extends ConsumerState<ElementListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _showSuggestions = _searchController.text.isNotEmpty;
      });
      ref.read(elementListProvider.notifier).filterElements(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final elements = ref.watch(elementListProvider);
    final favorites = ref.watch(favoritesProvider);
    final suggestions = ref.watch(elementListProvider.notifier).getSuggestions(_searchController.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Periodic Table'),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter functionality coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search elements...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: AppColors.textColor),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(elementListProvider.notifier).resetFilter();
                              setState(() {
                                _showSuggestions = false;
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: AppColors.textColor.withOpacity(0.5),
                    ),
                  ),
                  onChanged: (query) {
                    // Handled by _searchController listener
                  },
                ),
              ),
            ),
          ),
          // Suggestions Dropdown
          if (_showSuggestions && suggestions.isNotEmpty)
            Container(
              constraints: BoxConstraints(
                maxHeight: 200,
                maxWidth: screenWidth - 32,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return ListTile(
                    title: Text(
                      suggestion,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      _searchController.text = suggestion;
                      ref.read(elementListProvider.notifier).filterElements(suggestion);
                      setState(() {
                        _showSuggestions = false;
                      });
                    },
                  );
                },
              ),
            ),
          // Element List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: elements.length,
              itemBuilder: (context, index) {
                final element = elements[index];
                final isFavorite = favorites.any((fav) => fav.symbol == element.symbol);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: Hero(
                        tag: 'element_${element.symbol}',
                        child: CircleAvatar(
                          backgroundColor: AppColors.metalColor,
                          child: Text(
                            element.symbol,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        element.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Atomic Number: ${element.atomicNumber}',
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.7),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : AppColors.textColor,
                        ),
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).toggleFavorite(element);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ElementDetailsScreen(element: element),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}