import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';

abstract class ShippingMethodRepository {
  Future<List<ShippingMethodEntity>> getAllShippingMethods({
    bool refresh = false,
  });
  Future<ShippingMethodMapping?> calculateShipping({
    required String addressId,
    required String shippingMethodId,
    int? productId,
  });
}
