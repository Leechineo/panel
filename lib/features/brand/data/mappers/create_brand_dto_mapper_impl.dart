import 'package:leechineo_panel/features/brand/domain/dtos/create_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_color_mapper.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_icon_mapper.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/create_brand_dto_mapper.dart';

class CreateBrandDTOMapperImpl extends CreateBrandDTOMapper {
  final BrandIconMapper _brandIconMapper;
  final BrandColorMapper _brandColorMapper;

  CreateBrandDTOMapperImpl(this._brandIconMapper, this._brandColorMapper);

  @override
  Map<String, dynamic> fromDTOToMap(CreateBrandDTO dto) {
    return {
      'name': dto.name,
      'icon': _brandIconMapper.fromDTOToMap(dto.icon),
      'color': _brandColorMapper.fromDTOToMap(dto.color),
      'brandWebsite': dto.brandWebsite,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(entity) {
    throw UnimplementedError();
  }

  @override
  CreateBrandDTO fromMapToDTO(Map<String, dynamic> map) {
    return CreateBrandDTO(
      name: map['name'],
      icon: _brandIconMapper.fromMapToDTO(map['icon']),
      color: _brandColorMapper.fromMapToDTO(map['color']),
      brandWebsite: map['brandWebsite'],
    );
  }

  @override
  fromMapToEntity(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
