import 'package:flutter/material.dart';
import '../../domain/entities/element_entity.dart';
import '../../core/constants/app_colors.dart';

class ElementCard extends StatelessWidget {
  final ElementEntity element;
  final VoidCallback? onTap;

  const ElementCard({Key? key, required this.element, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: element.category == 'metal'
            ? AppColors.primaryColor
            : element.category == 'non-metal'
                ? AppColors.secondaryColor
                : AppColors.accentColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                element.symbol,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                element.name,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                element.atomicNumber.toString(),
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}