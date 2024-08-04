import 'package:leechineo_panel/features/stock/domain/dtos/update_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/mappers/update_stock_dto_mapper.dart';

class UpdateStockDTOMapperImpl extends UpdateStockDTOMapper {
  @override
  Map<String, dynamic> fromDTOToMap(UpdateStockDTO dto) {
    return <String, dynamic>{
      'id': dto.id,
      'name': dto.name,
      'country': dto.country,
      'currency': dto.currency,
      'shippingMethod': dto.shippingMethod,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(entity) {
    throw UnimplementedError();
  }

  @override
  UpdateStockDTO fromMapToDTO(Map<String, dynamic> map) {
    return UpdateStockDTO(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      currency: map['currency'] != null ? map['currency'] as String : null,
      shippingMethod: map['shippingMethod'] != null
          ? map['shippingMethod'] as String
          : null,
    );
  }

  @override
  fromMapToEntity(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
