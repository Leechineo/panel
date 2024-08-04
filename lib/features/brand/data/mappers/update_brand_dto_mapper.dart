import 'package:leechineo_panel/features/brand/domain/dtos/update_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_color_mapper.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_icon_mapper.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/update_brand_dto_mapper.dart';

class UpdateBrandDTOMapperImpl extends UpdateBrandDTOMapper {
  final BrandIconMapper _brandIconMapper;
  final BrandColorMapper _brandColorMapper;

  UpdateBrandDTOMapperImpl(this._brandIconMapper, this._brandColorMapper);

  @override
  Map<String, dynamic> fromDTOToMap(UpdateBrandDTO dto) {
    return {
      'id': dto.id,
      'name': dto.name,
      'icon':
          dto.icon != null ? _brandIconMapper.fromDTOToMap(dto.icon!) : null,
      'color':
          dto.color != null ? _brandColorMapper.fromDTOToMap(dto.color!) : null,
      'brandWebsite': dto.brandWebsite,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(entity) {
    throw UnimplementedError();
  }

  @override
  UpdateBrandDTO fromMapToDTO(Map<String, dynamic> map) {
    return UpdateBrandDTO(
      id: map['id'],
      name: map['name'],
      icon: map['icon'] != null
          ? _brandIconMapper.fromMapToDTO(map['icon'])
          : null,
      color: map['color'] != null
          ? _brandColorMapper.fromMapToDTO(map['color'])
          : null,
      brandWebsite: map['brandWebsite'],
    );
  }

  @override
  fromMapToEntity(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
