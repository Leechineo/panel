import 'package:leechineo_panel/features/shipping_method/domain/datasources/shipping_method_datasource.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/repositories/shipping_method_repository.dart';

class ShippingMethodRepositoryImpl implements ShippingMethodRepository {
  late final ShippingMethodDatasource _shippingMethodDatasource;

  ShippingMethodRepositoryImpl(
    ShippingMethodDatasource shippingMethodDatasource,
  ) {
    _shippingMethodDatasource = shippingMethodDatasource;
  }

  @override
  Future<List<ShippingMethodEntity>> getAllShippingMethods({
    bool refresh = false,
  }) async {
    final shippingMethods =
        await _shippingMethodDatasource.getAllShippingMethods();
    return shippingMethods;
  }

  @override
  Future<ShippingMethodMapping?> calculateShipping({
    required String addressId,
    required String shippingMethodId,
    int? productId,
  }) async {
    final shippingMethodMapping =
        await _shippingMethodDatasource.calculateShipping(
      addressId: addressId,
      shippingMethodId: shippingMethodId,
      productId: productId,
    );
    return shippingMethodMapping;
  }
}
