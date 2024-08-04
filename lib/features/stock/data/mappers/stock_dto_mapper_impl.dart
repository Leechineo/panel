import 'package:leechineo_panel/core/domain/enums/country_enum.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/features/stock/data/entities/stock_entity_impl.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/mappers/stock_dto_mapper.dart';

class StockDTOMapperImpl extends StockDTOMapper {
  @override
  Map<String, dynamic> fromDTOToMap(StockDTO dto) {
    return <String, dynamic>{
      'id': dto.id,
      'name': dto.name,
      'country': dto.country,
      'currency': dto.currency,
      'shippingMethod': dto.shippingMethod,
      'createdAt': dto.createdAt,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(StockEntity entity) {
    return <String, dynamic>{
      'id': entity.id,
      'name': entity.name,
      'country': countryEnumToString(entity.country),
      'currency': currencyEnumToString(entity.currency),
      'shippingMethod': entity.shippingMethod,
      'createdAt': entity.createdAt.toString(),
    };
  }

  @override
  StockDTO fromMapToDTO(Map<String, dynamic> map) {
    return StockDTO(
      id: map['id'] as String,
      name: map['name'] as String,
      country: map['country'] as String,
      currency: map['currency'] as String,
      shippingMethod: map['shippingMethod'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  @override
  StockEntity fromMapToEntity(Map<String, dynamic> map) {
    return StockEntityImpl(
      id: map['id'] as String,
      name: map['name'] as String,
      country: countryEnumFromString(map['country']),
      currency: currencyEnumFromString(map['currency']),
      shippingMethod: map['shippingMethod'] as String,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
