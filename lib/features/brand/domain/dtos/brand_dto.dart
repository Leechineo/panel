import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

class BrandDTO {
  final String id;
  final String name;
  final BrandIcon icon;
  final BrandColor color;
  final String brandWebsite;
  final String createdAt;

  BrandDTO({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.brandWebsite,
    required this.createdAt,
  });
}
