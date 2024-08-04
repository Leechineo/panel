import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/repositories/shipping_method_repository.dart';
import 'package:leechineo_panel/features/shipping_method/domain/usecases/calculate_shipping_usecase.dart';

class CalculateShippingUseCaseImpl implements CalculateShippingUseCase {
  final ShippingMethodRepository _shippingMethodRepository;

  CalculateShippingUseCaseImpl({
    required ShippingMethodRepository shippingMethodRepository,
  }) : _shippingMethodRepository = shippingMethodRepository;
  @override
  Future<ShippingMethodMapping?> call({
    required String addressId,
    required String shippingMethodId,
    int? productId,
  }) async {
    final shippingMapping = await _shippingMethodRepository.calculateShipping(
      addressId: addressId,
      shippingMethodId: shippingMethodId,
      productId: productId,
    );
    return shippingMapping;
  }
}
