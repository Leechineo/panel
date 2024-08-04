import 'package:leechineo_panel/features/product/domain/dtos/product_variants_option_dto.dart';
import 'package:leechineo_panel/features/product/domain/dtos/product_variants_property_dto.dart';

abstract class ProductVariantsDTO {
  final String? title;
  final String type;
  final List<ProductVariantsPropertyDTO> properties;
  final ProductVariantsOptionDTO? option;
  final List<ProductVariantsOptionDTO>? options;

  ProductVariantsDTO({
    required this.title,
    required this.type,
    required this.properties,
    required this.option,
    required this.options,
  });
}
