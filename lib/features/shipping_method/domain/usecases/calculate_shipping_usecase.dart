import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';

abstract class CalculateShippingUseCase {
  Future<ShippingMethodMapping?> call({
    required String addressId,
    required String shippingMethodId,
    int? productId,
  });
}
