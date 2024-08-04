import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/repositories/shipping_method_repository.dart';
import 'package:leechineo_panel/features/shipping_method/domain/usecases/get_all_shipping_methods_usecase.dart';

class GetAllShippingMethodsUseCaseImpl implements GetAllShippingMethodsUseCase {
  late final ShippingMethodRepository _shippingMethodRepository;

  GetAllShippingMethodsUseCaseImpl(
    final ShippingMethodRepository shippingMethodRepository,
  ) {
    _shippingMethodRepository = shippingMethodRepository;
  }

  @override
  Future<List<ShippingMethodEntity>> call({bool refresh = false}) async {
    final shippingMethods =
        await _shippingMethodRepository.getAllShippingMethods();
    return shippingMethods;
  }
}
