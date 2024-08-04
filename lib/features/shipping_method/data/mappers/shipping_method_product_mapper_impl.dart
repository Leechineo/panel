import 'package:leechineo_panel/features/shipping_method/data/dtos/shipping_method_product_dto_impl.dart';
import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_product_dto.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_mapping_mapper.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_product_mapper.dart';

class ShippingMethodProductMapperImpl extends ShippingMethodProductMapper {
  late final ShippingMethodMappingMapper _shippingMethodMappingMapper;

  ShippingMethodProductMapperImpl(
      ShippingMethodMappingMapper shippingMethodMappingMapper) {
    _shippingMethodMappingMapper = shippingMethodMappingMapper;
  }
  @override
  ShippingMethodProductDTO fromMapToDTO(Map<String, dynamic> map) {
    return ShippingMethodProductDTOImpl(
      id: map['id'],
      mappings: (map['mappings'] as List)
          .map(
            (e) => _shippingMethodMappingMapper.fromMapToDTO(e),
          )
          .toList(),
    );
  }

  @override
  ShippingMethodProduct fromMapToEntity(Map<String, dynamic> map) {
    return ShippingMethodProduct(
      id: map['id'],
      mappings: (map['mappings'] as List)
          .map(
            (e) => _shippingMethodMappingMapper.fromMapToEntity(e),
          )
          .toList(),
    );
  }

  @override
  Map<String, dynamic> fromDTOToMap(ShippingMethodProductDTO dto) {
    return <String, dynamic>{
      'id': dto.id,
      'mappings': dto.mappings
          .map((x) => _shippingMethodMappingMapper.fromDTOToMap(x))
          .toList(),
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(ShippingMethodProduct entity) {
    return <String, dynamic>{
      'id': entity.id,
      'mappings': entity.mappings
          .map(
            (x) => _shippingMethodMappingMapper.fromEntityToMap(x),
          )
          .toList(),
    };
  }
}
