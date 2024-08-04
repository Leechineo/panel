import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';

class ShippingMethodEntityImpl extends ShippingMethodEntity {
  ShippingMethodEntityImpl({
    required super.id,
    required super.name,
    required super.defaultMapping,
    required super.mappings,
    required super.products,
    required super.createdAt,
  });
}
