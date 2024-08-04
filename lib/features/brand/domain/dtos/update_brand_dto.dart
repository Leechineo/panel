import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

class UpdateBrandDTO {
  final String id;
  final String? name;
  final BrandIcon? icon;
  final BrandColor? color;
  final String? brandWebsite;

  UpdateBrandDTO({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.brandWebsite,
  });
}
