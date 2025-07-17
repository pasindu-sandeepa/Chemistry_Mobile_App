import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/element_entity.dart';
import '../providers/favorites_provider.dart';

class ElementDetailsScreen extends ConsumerWidget {
  final ElementEntity element;

  const ElementDetailsScreen({super.key, required this.element});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isFavorite = ref.watch(favoritesProvider).any((fav) => fav.symbol == element.symbol);

    return Scaffold(
      appBar: AppBar(
        title: Text(element.name),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              ref.read(favoritesProvider.notifier).toggleFavorite(element);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Widget for Symbol
            Center(
              child: Hero(
                tag: 'element_${element.symbol}',
                child: CircleAvatar(
                  radius: screenWidth * 0.15,
                  backgroundColor: AppColors.metalColor,
                  child: Text(
                    element.symbol,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Element Details Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Element Name
                    Row(
                      children: [
                        const Icon(Icons.label, color: AppColors.primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Name: ${element.name}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Atomic Number
                    Row(
                      children: [
                        const Icon(Icons.numbers, color: AppColors.primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Atomic Number: ${element.atomicNumber}',
                          style: TextStyle(
                            color: AppColors.textColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Atomic Mass
                    Row(
                      children: [
                        const Icon(Icons.science, color: AppColors.primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Atomic Mass: ${element.atomicMass}',
                          style: TextStyle(
                            color: AppColors.textColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Category
                    Row(
                      children: [
                        const Icon(Icons.category, color: AppColors.primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          'Category: ${element.category}',
                          style: TextStyle(
                            color: AppColors.textColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Description/Fun Fact
                    Row(
                      children: [
                        const Icon(Icons.info, color: AppColors.primaryColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Fun Fact: ${element.description}',
                            style: TextStyle(
                              color: AppColors.textColor.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Optional Image (Placeholder)
            Center(
              child: Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.backgroundColor,
                ),
                child: const Center(
                  child: Text(
                    'Element Image Placeholder',
                    style: TextStyle(fontSize: 16, color: AppColors.textColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}