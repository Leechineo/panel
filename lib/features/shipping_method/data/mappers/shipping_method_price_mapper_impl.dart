import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/features/shipping_method/data/dtos/shipping_method_price_dto_impl.dart';
import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_price_dto.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/mappers/shipping_method_price_mapper.dart';

class ShippingMethodPriceMapperImpl extends ShippingMethodPriceMapper {
  @override
  ShippingMethodPriceDTO fromMapToDTO(Map<String, dynamic> map) {
    return ShippingMethodPriceDTOImpl(
      currency: map['currency'],
      value: map['value'],
    );
  }

  @override
  ShippingMethodPrice fromMapToEntity(Map<String, dynamic> map) {
    return ShippingMethodPrice(
      currency: currencyEnumFromString(map['currency']),
      value: map['value'] * 1.0,
    );
  }

  @override
  Map<String, dynamic> fromDTOToMap(ShippingMethodPriceDTO dto) {
    return <String, dynamic>{
      'currency': dto.currency,
      'value': dto.value,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(ShippingMethodPrice entity) {
    return <String, dynamic>{
      'currency': currencyEnumToString(entity.currency),
      'value': entity.value,
    };
  }
}
