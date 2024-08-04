import 'package:leechineo_panel/features/product/domain/dtos/product_variants_option_name_dto.dart';

abstract class ProductVariantsOptionDTO {
  final String id;
  final String? name;
  final List<ProductVariantsOptionNameDTO>? names;
  final List<String>? images;
  final int instock;
  final double price;

  ProductVariantsOptionDTO({
    required this.id,
    required this.name,
    required this.names,
    required this.images,
    required this.instock,
    required this.price,
  });
}
