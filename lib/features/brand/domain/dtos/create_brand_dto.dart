import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

class CreateBrandDTO {
  final String name;
  final BrandIcon icon;
  final BrandColor color;
  final String brandWebsite;

  CreateBrandDTO({
    required this.name,
    required this.icon,
    required this.color,
    required this.brandWebsite,
  });
}
