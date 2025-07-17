import 'package:equatable/equatable.dart';

class ElementEntity extends Equatable {
  final String name;
  final String symbol;
  final int atomicNumber;
  final double atomicMass;
  final String category;
  final String description;
  final bool isFavorite;

  const ElementEntity({
    required this.name,
    required this.symbol,
    required this.atomicNumber,
    required this.atomicMass,
    required this.category,
    required this.description,
    this.isFavorite = false,
  });

  // Create a copy with updated fields
  ElementEntity copyWith({
    String? name,
    String? symbol,
    int? atomicNumber,
    double? atomicMass,
    String? category,
    String? description,
    bool? isFavorite,
  }) {
    return ElementEntity(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      atomicNumber: atomicNumber ?? this.atomicNumber,
      atomicMass: atomicMass ?? this.atomicMass,
      category: category ?? this.category,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [
    name,
    symbol,
    atomicNumber,
    atomicMass,
    category,
    description,
    isFavorite,
  ];
}
