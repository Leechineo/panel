import 'package:leechineo_panel/features/product/data/models/product_variants_model.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class ProductStockModel implements ProductStock {
  @override
  final String stock;

  @override
  final ProductVariantsModel variants;

  ProductStockModel({
    required this.stock,
    required this.variants,
  });

  factory ProductStockModel.fromJson(Map<String, dynamic> json) {
    return ProductStockModel(
      stock: json['stock'],
      variants: ProductVariantsModel.fromJson(json['variants']),
    );
  }

  ProductStockModel copyWith({
    String? stock,
    ProductVariantsModel? variants,
  }) {
    return ProductStockModel(
      stock: stock ?? this.stock,
      variants: variants ?? this.variants,
    );
  }

  factory ProductStockModel.newWith({
    String? stock,
    ProductVariantsModel? variants,
  }) {
    return ProductStockModel(
      stock: stock ?? '',
      variants: variants ?? ProductVariantsModel.newWith(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stock': stock,
      'variants': variants.toJson(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
