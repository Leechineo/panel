import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';

class OptionShippingEntity {
  final int? productId;
  final String shippingMethodId;
  final ShippingMethodMapping shippingMethodMapping;

  OptionShippingEntity({
    this.productId,
    required this.shippingMethodId,
    required this.shippingMethodMapping,
  });

  @override
  String toString() =>
      'OptionShippingEntity(productId: $productId, shippingMethodId: $shippingMethodId, shippingMethodMapping: $shippingMethodMapping)';
}
