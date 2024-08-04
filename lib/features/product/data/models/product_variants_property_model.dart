import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class ProductVariantsPropertyModel implements ProductVariantsProperty {
  @override
  final String id;
  @override
  final String name;

  ProductVariantsPropertyModel({
    required this.id,
    required this.name,
  });

  factory ProductVariantsPropertyModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantsPropertyModel(
      id: json['id'],
      name: json['name'],
    );
  }

  ProductVariantsPropertyModel copyWith({
    String? id,
    String? name,
  }) {
    return ProductVariantsPropertyModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory ProductVariantsPropertyModel.newWith({
    String? id,
    String? name,
  }) {
    return ProductVariantsPropertyModel(
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
