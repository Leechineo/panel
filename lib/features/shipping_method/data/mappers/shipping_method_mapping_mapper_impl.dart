import 'package:leechineo_panel/core/domain/enums/region_radius_enum.dart';
import 'package:leechineo_panel/features/shipping_method/data/dtos/shipping_method_mapping_dto_impl.dart';
import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_mapping_dto.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_arrive_time_mapper.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_mapping_mapper.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_price_mapper.dart';

class ShippingMethodMappingMapperImpl extends ShippingMethodMappingMapper {
  late final ShippingMethodArriveTimeMapper _shippingMethodArriveTimeMapper;
  late final ShippingMethodPriceMapper _shippingMethodPriceMapper;

  ShippingMethodMappingMapperImpl(
    ShippingMethodArriveTimeMapper shippingMethodArriveTimeMapper,
    ShippingMethodPriceMapper shippingMethodPriceMapper,
  ) {
    _shippingMethodArriveTimeMapper = shippingMethodArriveTimeMapper;
    _shippingMethodPriceMapper = shippingMethodPriceMapper;
  }
  @override
  ShippingMethodMappingDTO fromMapToDTO(Map<String, dynamic> map) {
    return ShippingMethodMappingDTOImpl(
      regionRadius: map['regionRadius'],
      arriveTime: _shippingMethodArriveTimeMapper.fromMapToDTO(map),
      price: _shippingMethodPriceMapper.fromMapToDTO(map),
    );
  }

  @override
  ShippingMethodMapping fromMapToEntity(Map<String, dynamic> map) {
    return ShippingMethodMapping(
      id: map['id'],
      regionRadius: map['regionRadius'] != null
          ? regionRadiusEnumFromString(map['regionRadius'])
          : null,
      price: _shippingMethodPriceMapper.fromMapToEntity(
        map['price'],
      ),
      zipcode: map['zipcode'],
      arriveTime: _shippingMethodArriveTimeMapper.fromMapToEntity(
        map['arriveTime'],
      ),
    );
  }

  @override
  Map<String, dynamic> fromDTOToMap(ShippingMethodMappingDTO dto) {
    return <String, dynamic>{
      'id': dto.id,
      'zipcode': dto.zipcode,
      'regionRadius': dto.regionRadius,
      'arriveTime':
          _shippingMethodArriveTimeMapper.fromDTOToMap(dto.arriveTime),
      'price': _shippingMethodPriceMapper.fromDTOToMap(dto.price),
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(ShippingMethodMapping entity) {
    return <String, dynamic>{
      'id': entity.id,
      'zipcode': entity.zipcode,
      'regionRadius': entity.regionRadius != null
          ? regionRadiusEnumToString(entity.regionRadius!)
          : null,
      'arriveTime':
          _shippingMethodArriveTimeMapper.fromEntityToDTO(entity.arriveTime),
      'price': _shippingMethodPriceMapper.fromEntityToMap(entity.price),
    };
  }
}
