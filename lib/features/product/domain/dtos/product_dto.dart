import 'package:leechineo_panel/features/product/domain/dtos/product_specification_dto.dart';
import 'package:leechineo_panel/features/product/domain/dtos/product_stock_dto.dart';

abstract class ProductDTO {
  final int id;
  final String name;
  final String description;
  final List<String> images;
  final List<ProductSpecificationDTO> specifications;
  final String category;
  final String brand;
  final String? type;
  final List<ProductStockDTO> stocks;
  final bool? private;
  final String createdAt;

  ProductDTO({
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
