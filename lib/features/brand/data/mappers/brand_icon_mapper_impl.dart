import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_icon_mapper.dart';

class BrandIconMapperImpl extends BrandIconMapper {
  @override
  Map<String, dynamic> fromDTOToMap(BrandIcon dto) {
    return {
      'default': dto.light,
      'dark': dto.dark,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(entity) {
    return fromDTOToMap(entity);
  }

  @override
  BrandIcon fromMapToDTO(Map<String, dynamic> map) {
    return BrandIcon(
      light: map['default'],
      dark: map['dark'],
    );
  }

  @override
  BrandIcon fromMapToEntity(Map<String, dynamic> map) {
    return fromMapToDTO(map);
  }
}
