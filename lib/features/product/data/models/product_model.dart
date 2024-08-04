import 'package:leechineo_panel/features/product/data/models/product_specification_model.dart';
import 'package:leechineo_panel/features/product/data/models/product_stock_model.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class ProductModel implements ProductEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final List<String> images;
  @override
  final List<ProductSpecificationModel> specifications;
  @override
  final String category;
  @override
  final String brand;
  @override
  final String? type;
  @override
  final List<ProductStockModel> stocks;
  @override
  final bool? private;
  @override
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.specifications,
    required this.category,
    required this.brand,
    required this.type,
    required this.stocks,
    required this.private,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> imagesList = json['images'];
    final List<String> images = imagesList.cast<String>();
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      images: images,
      specifications: (json['specifications'] as List)
          .map((e) => ProductSpecificationModel.fromJson(e))
          .toList(),
      category: json['category'],
      brand: json['brand'],
      type: json['type'],
      stocks: (json['stocks'] as List)
          .map((e) => ProductStockModel.fromJson(e))
          .toList(),
      private: json['private'],
      createdAt: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
    );
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    List<String>? images,
    List<ProductSpecificationModel>? specifications,
    String? category,
    String? brand,
    String? type,
    List<ProductStockModel>? stocks,
    bool? private,
    DateTime? createdAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      specifications: specifications ?? this.specifications,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      type: type ?? this.type,
      stocks: stocks ?? this.stocks,
      private: private ?? this.private,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory ProductModel.newWith({
    int? id,
    String? name,
    String? description,
    List<String>? images,
    List<ProductSpecificationModel>? specifications,
    String? category,
    String? brand,
    String? type,
    List<ProductStockModel>? stocks,
    bool? private,
    DateTime? createdAt,
  }) {
    return ProductModel(
      id: id ?? 0,
      name: name ?? '',
      description: description ?? '',
      images: images ?? [],
      specifications: specifications ?? [],
      category: category ?? '',
      brand: brand ?? '',
      type: type ?? '',
      stocks: stocks ?? [],
      private: private ?? false,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'specifications': specifications.map((e) => e.toJson()),
      'category': category,
      'brand': brand,
      'type': type,
      'stocks': stocks.map((e) => e.toJson()),
      'private': private,
      'createdAt': createdAt.toString(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
