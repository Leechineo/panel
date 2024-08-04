import 'package:leechineo_panel/features/shipping_method/data/dtos/shipping_method_dto_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/entities/shipping_method_entity_impl.dart';
import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_dto.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_mapper.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_mapping_mapper.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_product_mapper.dart';

class ShippingMethodMapperImpl extends ShippingMethodMapper {
  late final ShippingMethodMappingMapper _shippingMethodMappingMapper;
  late final ShippingMethodProductMapper _shippingMethodProductMapper;

  ShippingMethodMapperImpl(
    ShippingMethodMappingMapper shippingMethodMappingMapper,
    ShippingMethodProductMapper shippingMethodProductMapper,
  ) {
    _shippingMethodMappingMapper = shippingMethodMappingMapper;
    _shippingMethodProductMapper = shippingMethodProductMapper;
  }
  @override
  ShippingMethodDTO fromMapToDTO(Map<String, dynamic> map) {
    return ShippingMethodDTOImpl(
      id: map['id'],
      name: map['name'],
      defaultMapping:
          _shippingMethodMappingMapper.fromMapToDTO(map['defaultMapping']),
      mappings: (map['mappings'] as List)
          .map((e) => _shippingMethodMappingMapper.fromMapToDTO(e))
          .toList(),
      products: (map['products'] as List)
          .map((product) => _shippingMethodProductMapper.fromMapToDTO(product))
          .toList(),
      createdAt: map['createdAt'],
    );
  }

  @override
  ShippingMethodEntity fromMapToEntity(Map<String, dynamic> map) {
    return ShippingMethodEntityImpl(
      id: map['id'],
      name: map['name'],
      defaultMapping: _shippingMethodMappingMapper.fromMapToEntity(
        map['defaultMapping'],
      ),
      mappings: (map['mappings'] as List)
          .map(
            (e) => _shippingMethodMappingMapper.fromMapToEntity(e),
          )
          .toList(),
      products: (map['products'] as List)
          .map(
            (product) => _shippingMethodProductMapper.fromMapToEntity(product),
          )
          .toList(),
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
    );
  }

  @override
  Map<String, dynamic> fromDTOToMap(ShippingMethodDTO dto) {
    return <String, dynamic>{
      'id': dto.id,
      'name': dto.name,
      'defaultMapping':
          _shippingMethodMappingMapper.fromDTOToMap(dto.defaultMapping),
      'mappings': dto.mappings
          .map((x) => _shippingMethodMappingMapper.fromDTOToMap(x))
          .toList(),
      'products': dto.products
          .map((x) => _shippingMethodProductMapper.fromDTOToMap(x))
          .toList(),
      'createdAt': dto.createdAt,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(ShippingMethodEntity entity) {
    return <String, dynamic>{
      'id': entity.id,
      'name': entity.name,
      'defaultMapping':
          _shippingMethodMappingMapper.fromEntityToMap(entity.defaultMapping),
      'mappings': entity.mappings
          .map((x) => _shippingMethodMappingMapper.fromEntityToMap(x))
          .toList(),
      'products': entity.products
          .map((x) => _shippingMethodProductMapper.fromEntityToMap(x))
          .toList(),
      'createdAt': entity.createdAt.millisecondsSinceEpoch,
    };
  }
}
