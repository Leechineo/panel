import 'package:leechineo_panel/features/product/domain/dtos/product_variants_dto.dart';

abstract class ProductStockDTO {
  final String stock;
  final ProductVariantsDTO variants;

  ProductStockDTO({
    required this.stock,
    required this.variants,
  });
}
