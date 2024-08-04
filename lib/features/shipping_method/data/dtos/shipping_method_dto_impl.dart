import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_dto.dart';

class ShippingMethodDTOImpl extends ShippingMethodDTO {
  ShippingMethodDTOImpl({
    required super.id,
    required super.name,
    required super.defaultMapping,
    required super.mappings,
    required super.products,
    required super.createdAt,
  });
}
