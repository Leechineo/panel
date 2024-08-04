import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_mapping_dto.dart';
import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_product_dto.dart';

abstract class ShippingMethodDTO {
  final String id;
  final String name;
  final ShippingMethodMappingDTO defaultMapping;
  final List<ShippingMethodMappingDTO> mappings;
  final List<ShippingMethodProductDTO> products;
  final String createdAt;

  ShippingMethodDTO({
    required this.id,
    required this.name,
    required this.defaultMapping,
    required this.mappings,
    required this.products,
    required this.createdAt,
  });
}
