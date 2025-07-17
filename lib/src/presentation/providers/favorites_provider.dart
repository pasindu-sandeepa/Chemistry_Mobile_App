import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/element_entity.dart';

// Define the FavoritesProvider
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<ElementEntity>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<ElementEntity>> {
  FavoritesNotifier() : super([]); // Initialize with empty list

  // Toggle favorite status
  void toggleFavorite(ElementEntity element) {
    if (state.any((fav) => fav.symbol == element.symbol)) {
      state = state.where((fav) => fav.symbol != element.symbol).toList();
    } else {
      state = [
        ...state,
        element.copyWith(isFavorite: true),
      ];
    }
  }
}