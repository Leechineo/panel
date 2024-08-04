import 'package:leechineo_panel/core/domain/mappers/app_mapper.dart';
import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_mapping_dto.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';

abstract class ShippingMethodMappingMapper
    extends AppMapper<ShippingMethodMappingDTO, ShippingMethodMapping> {}
