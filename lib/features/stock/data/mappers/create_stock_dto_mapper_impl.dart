import 'package:leechineo_panel/features/stock/domain/dtos/create_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/mappers/create_stock_dto_mapper.dart';

class CreateStockDTOMapperImpl extends CreateStockDTOMapper {
  @override
  Map<String, dynamic> fromDTOToMap(CreateStockDTO dto) {
    return <String, dynamic>{
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
  CreateStockDTO fromMapToDTO(Map<String, dynamic> map) {
    return CreateStockDTO(
      name: map['name'] as String,
      country: map['country'] as String,
      currency: map['currency'] as String,
      shippingMethod: map['shippingMethod'] as String,
    );
  }

  @override
  fromMapToEntity(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
