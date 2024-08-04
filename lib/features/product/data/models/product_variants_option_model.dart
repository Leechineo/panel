import 'package:leechineo_panel/features/product/data/models/product_variants_option_name_model.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class ProductVariantsOptionModel implements ProductVariantsOption {
  @override
  final String id;
  @override
  final String? name;
  @override
  final List<ProductVariantsOptionNameModel>? names;
  @override
  final List<String>? images;
  @override
  final int instock;
  @override
  final double price;

  ProductVariantsOptionModel({
    required this.id,
    required this.name,
    required this.names,
    required this.images,
    required this.instock,
    required this.price,
  });

  factory ProductVariantsOptionModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? imagesList = json['images'];
    final List<String>? images = imagesList?.cast<String>();
    return ProductVariantsOptionModel(
      id: json['id'],
      name: json['name'],
      names: ((json['names'] ?? []) as List)
          .map((e) => ProductVariantsOptionNameModel.fromJson(e))
          .toList(),
      images: images,
      instock: json['instock'],
      price: (json['price'] as num).toDouble(),
    );
  }

  ProductVariantsOptionModel copyWith({
    String? id,
    String? name,
    List<ProductVariantsOptionNameModel>? names,
    List<String>? images,
    int? instock,
    double? price,
  }) {
    return ProductVariantsOptionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      names: names ?? this.names,
      images: images ?? this.images,
      instock: instock ?? this.instock,
      price: price ?? this.price,
    );
  }

  factory ProductVariantsOptionModel.newWith({
    String? id,
    String? name,
    List<ProductVariantsOptionNameModel>? names,
    List<String>? images,
    int? instock,
    double? price,
  }) {
    return ProductVariantsOptionModel(
      id: id ?? '',
      name: name ?? '',
      names: names ?? [],
      images: images ?? [],
      instock: instock ?? 0,
      price: price ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'names': names?.map((e) => e.toJson()) ?? [],
      'images': images,
      'instock': instock,
      'price': price,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
