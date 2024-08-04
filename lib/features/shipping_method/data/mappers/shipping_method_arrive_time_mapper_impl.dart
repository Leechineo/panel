import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_arrive_time_dto.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_arrive_time_mapper.dart';

class ShippingMethodArriveTimeMapperImpl
    extends ShippingMethodArriveTimeMapper {
  @override
  ShippingMethodArriveTimeDTO fromMapToDTO(Map<String, dynamic> map) {
    return ShippingMethodArriveTimeDTO(
      min: map['min'],
      max: map['max'],
    );
  }

  @override
  ShippingMethodArriveTime fromMapToEntity(Map<String, dynamic> map) {
    return ShippingMethodArriveTime(
      min: map['min'],
      max: map['max'],
    );
  }

  @override
  Map<String, dynamic> fromDTOToMap(ShippingMethodArriveTimeDTO dto) {
    return <String, dynamic>{
      'min': dto.min,
      'max': dto.max,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(ShippingMethodArriveTime entity) {
    return <String, dynamic>{
      'min': entity.min,
      'max': entity.max,
    };
  }
}
