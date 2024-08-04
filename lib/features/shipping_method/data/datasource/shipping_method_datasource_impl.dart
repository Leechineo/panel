import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/datasources/app_datasource.dart';
import 'package:leechineo_panel/features/shipping_method/domain/datasources/shipping_method_datasource.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_mapper.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_mapping_mapper.dart';

class ShippingMethodDatasourceImpl extends AppDatasource
    implements ShippingMethodDatasource {
  late final HttpAdapter _httpAdapter;
  late final ShippingMethodMapper _shippingMethodMapper;
  late final ShippingMethodMappingMapper _shippingMethodMappingMapper;

  ShippingMethodDatasourceImpl(
    HttpAdapter httpAdapter,
    ShippingMethodMapper shippingMethodMapper,
    ShippingMethodMappingMapper shippingMethodMappingMapper,
  ) {
    _httpAdapter = httpAdapter;
    _shippingMethodMapper = shippingMethodMapper;
    _shippingMethodMappingMapper = shippingMethodMappingMapper;
  }
  @override
  Future<List<ShippingMethodEntity>> getAllShippingMethods({
    bool refresh = false,
  }) async {
    final shippingMethods = await exec<List<ShippingMethodEntity>>(
      () async {
        final response = await _httpAdapter.get('/shipping_methods');
        final shippingMethods = (response.data as List).map(
          (e) => _shippingMethodMapper.fromMapToEntity(e),
        );
        return shippingMethods.toList();
      },
    );
    return shippingMethods;
  }

  @override
  Future<ShippingMethodMapping?> calculateShipping({
    required String addressId,
    required String shippingMethodId,
    int? productId,
  }) async {
    return exec<ShippingMethodMapping?>(() async {
      final response = await _httpAdapter.get(
        '/shipping_methods/calculate_shipping',
        params: {
          'shippingMethodId': shippingMethodId,
          'addressId': addressId,
          'productId': productId,
        },
      );
      if (response.data != null) {
        return _shippingMethodMappingMapper.fromMapToEntity(
          response.data,
        );
      }
      return null;
    });
  }
}
