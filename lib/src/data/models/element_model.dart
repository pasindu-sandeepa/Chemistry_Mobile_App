import '../../domain/entities/element_entity.dart';

class ElementModel extends ElementEntity {
  ElementModel({
    required int atomicNumber,
    required String symbol,
    required String name,
    required double atomicMass,
    required String category,
  }) : super(
          atomicNumber: atomicNumber,
          symbol: symbol,
          name: name,
          atomicMass: atomicMass,
          category: category,
        );

  factory ElementModel.fromJson(Map<String, dynamic> json) {
    return ElementModel(
      atomicNumber: json['atomicNumber'],
      symbol: json['symbol'],
      name: json['name'],
      atomicMass: json['atomicMass'].toDouble(),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'atomicNumber': atomicNumber,
      'symbol': symbol,
      'name': name,
      'atomicMass': atomicMass,
      'category': category,
    };
  }
}