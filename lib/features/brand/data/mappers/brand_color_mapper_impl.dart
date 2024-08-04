import 'dart:ui';

import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_color_mapper.dart';

class BrandColorMapperImpl extends BrandColorMapper {
  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase().substring(2)}';
  }

  @override
  Map<String, dynamic> fromDTOToMap(BrandColor dto) {
    return {
      'default': colorToHex(dto.light),
      'dark': colorToHex(dto.dark),
    };
  }

  Color hexToColor(String hexString) {
    String formattedString = hexString.replaceAll('#', '');
    int colorValue = int.parse(formattedString, radix: 16);
    return Color(colorValue).withOpacity(1.0);
  }

  @override
  BrandColor fromMapToDTO(Map<String, dynamic> map) {
    return BrandColor(
      light: hexToColor(map['default']),
      dark: hexToColor(map['dark']),
    );
  }

  @override
  BrandColor fromMapToEntity(Map<String, dynamic> map) {
    return fromMapToDTO(map);
  }

  @override
  Map<String, dynamic> fromEntityToMap(entity) {
    return fromDTOToMap(entity);
  }
}
