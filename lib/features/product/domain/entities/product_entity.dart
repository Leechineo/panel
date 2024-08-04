import 'package:leechineo_panel/features/product/domain/enums/product_variants_type_enum.dart';

abstract class ProductSpecification {
  final String id;
  final String title;
  final String value;

  ProductSpecification({
    required this.id,
    required this.title,
    required this.value,
  });
}

abstract class ProductVariantsProperty {
  final String id;
  final String name;

  ProductVariantsProperty({
    required this.id,
    required this.name,
  });
}

abstract class ProductVariantsOptionName {
  final String id;
  final String name;

  ProductVariantsOptionName({
    required this.id,
    required this.name,
  });
}

abstract class ProductVariantsOption {
  final String id;
  final String? name;
  final List<ProductVariantsOptionName>? names;
  final List<String>? images;
  final int instock;
  final double price;

  ProductVariantsOption({
    required this.id,
    required this.name,
    required this.names,
    required this.images,
    required this.instock,
    required this.price,
  });
}

abstract class ProductVariants {
  final String? title;
  final ProductVariantsTypeEnum type;
  final List<ProductVariantsProperty> properties;
  final ProductVariantsOption? option;
  final List<ProductVariantsOption>? options;

  ProductVariants({
    required this.title,
    required this.type,
    required this.properties,
    required this.option,
    required this.options,
  });
}

abstract class ProductStock {
  final String stock;
  final ProductVariants variants;

  ProductStock({
    required this.stock,
    required this.variants,
  });
}

abstract class ProductEntity {
  final int id;
  final String name;
  final String description;
  final List<String> images;
  final List<ProductSpecification> specifications;
  final String category;
  final String brand;
  final String? type;
  final List<ProductStock> stocks;
  final bool? private;
  final DateTime createdAt;

  ProductEntity({
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
}
