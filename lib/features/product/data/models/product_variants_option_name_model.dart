import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class ProductVariantsOptionNameModel implements ProductVariantsOptionName {
  @override
  final String id;
  @override
  final String name;

  ProductVariantsOptionNameModel({
    required this.id,
    required this.name,
  });

  factory ProductVariantsOptionNameModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantsOptionNameModel(
      id: json['id'],
      name: json['name'],
    );
  }

  ProductVariantsOptionNameModel copyWith({
    String? id,
    String? name,
  }) {
    return ProductVariantsOptionNameModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory ProductVariantsOptionNameModel.newWith({
    String? id,
    String? name,
  }) {
    return ProductVariantsOptionNameModel(
      id: id ?? '',
      name: name ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
