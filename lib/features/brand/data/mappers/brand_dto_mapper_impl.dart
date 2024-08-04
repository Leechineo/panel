import 'package:leechineo_panel/features/brand/data/entities/brand_entity_impl.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_color_mapper.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_icon_mapper.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_dto_mapper.dart';

class BrandDTOMapperImpl extends BrandDTOMapper {
  final BrandIconMapper _brandIconMapper;
  final BrandColorMapper _brandColorMapper;

  BrandDTOMapperImpl(this._brandIconMapper, this._brandColorMapper);

  @override
  Map<String, dynamic> fromDTOToMap(BrandDTO dto) {
    return {
      'id': dto.id,
      'name': dto.name,
      'icon': _brandIconMapper.fromDTOToMap(dto.icon),
      'color': _brandColorMapper.fromDTOToMap(dto.color),
      'brandWebsite': dto.brandWebsite,
      'createdAt': dto.createdAt.toString(),
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(BrandEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'icon': _brandIconMapper.fromDTOToEntity(entity.icon),
      'color': _brandColorMapper.fromDTOToEntity(entity.color),
      'brandWebsite': entity.brandWebsite,
      'createdAt': entity.createdAt.toString(),
    };
  }

  @override
  BrandDTO fromMapToDTO(Map<String, dynamic> map) {
    return BrandDTO(
      id: map['id'],
      name: map['name'],
      icon: _brandIconMapper.fromMapToDTO(map['icon']),
      color: _brandColorMapper.fromMapToDTO(map['color']),
      brandWebsite: map['brandWebsite'],
      createdAt: map['createdAt'],
    );
  }

  @override
  BrandEntity fromMapToEntity(Map<String, dynamic> map) {
    return BrandEntityImpl(
      id: map['id'],
      name: map['name'],
      icon: _brandIconMapper.fromMapToEntity(map['icon']),
      color: _brandColorMapper.fromMapToEntity(map['color']),
      brandWebsite: map['brandWebsite'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
