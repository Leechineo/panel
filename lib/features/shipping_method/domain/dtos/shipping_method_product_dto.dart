import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_mapping_dto.dart';

abstract class ShippingMethodProductDTO {
  final String id;
  final List<ShippingMethodMappingDTO> mappings;

  ShippingMethodProductDTO({
    required this.id,
    required this.mappings,
  });
}
