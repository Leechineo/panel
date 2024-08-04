import 'package:leechineo_panel/features/product/data/models/product_variants_option_model.dart';
import 'package:leechineo_panel/features/product/data/models/product_variants_property_model.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/product/domain/enums/product_variants_type_enum.dart';

class ProductVariantsModel implements ProductVariants {
  @override
  final String? title;

  @override
  final ProductVariantsTypeEnum type;

  @override
  final List<ProductVariantsPropertyModel> properties;

  @override
  final ProductVariantsOptionModel? option;

  @override
  final List<ProductVariantsOptionModel>? options;

  ProductVariantsModel({
    required this.title,
    required this.type,
    required this.properties,
    required this.option,
    required this.options,
  });

  factory ProductVariantsModel.fromJson(Map<String, dynamic> json) {
    ProductVariantsTypeEnum variantsTypeFromString(String type) {
      switch (type) {
        case 'unique':
          return ProductVariantsTypeEnum.unique;
        case 'compound':
          return ProductVariantsTypeEnum.compound;
        case 'simple':
          return ProductVariantsTypeEnum.simple;
        default:
          return ProductVariantsTypeEnum.simple;
      }
    }

    return ProductVariantsModel(
      title: json['title'],
      type: variantsTypeFromString(json['type']),
      properties: (json['properties'] as List)
          .map((e) => ProductVariantsPropertyModel.fromJson(e))
          .toList(),
      option: json['option'] != null
          ? ProductVariantsOptionModel.fromJson(json['option'])
          : null,
      options: (json['options'] as List)
          .map((e) => ProductVariantsOptionModel.fromJson(e))
          .toList(),
    );
  }

  ProductVariantsModel copyWith({
    String? title,
    ProductVariantsTypeEnum? type,
    List<ProductVariantsPropertyModel>? properties,
    ProductVariantsOptionModel? option,
    List<ProductVariantsOptionModel>? options,
  }) {
    return ProductVariantsModel(
      title: title ?? this.title,
      type: type ?? this.type,
      properties: properties ?? this.properties,
      option: option ?? this.option,
      options: options ?? this.options,
    );
  }

  factory ProductVariantsModel.newWith({
    String? title,
    ProductVariantsTypeEnum? type,
    List<ProductVariantsPropertyModel>? properties,
    ProductVariantsOptionModel? option,
    List<ProductVariantsOptionModel>? options,
  }) {
    return ProductVariantsModel(
      title: title ?? '',
      type: type ?? ProductVariantsTypeEnum.simple,
      properties: properties ?? [],
      option: option,
      options: options,
    );
  }

  Map<String, dynamic> toJson() {
    String variantsTypeToString(ProductVariantsTypeEnum type) {
      switch (type) {
        case ProductVariantsTypeEnum.unique:
          return 'unique';
        case ProductVariantsTypeEnum.compound:
          return 'compound';
        case ProductVariantsTypeEnum.simple:
          return 'simple';
        default:
          return 'simple';
      }
    }

    return {
      'title': title,
      'type': variantsTypeToString(type),
      'properties': properties.map((e) => e.toJson()),
      'option': option,
      'options': options,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
