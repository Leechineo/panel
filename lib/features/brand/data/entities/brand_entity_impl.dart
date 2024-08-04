import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

class BrandEntityImpl extends BrandEntity {
  BrandEntityImpl({
    required super.id,
    required super.name,
    required super.icon,
    required super.color,
    required super.brandWebsite,
    required super.createdAt,
  });

  BrandEntityImpl copyWith({
    String? id,
    String? name,
    BrandIcon? icon,
    BrandColor? color,
    String? brandWebsite,
    DateTime? createdAt,
  }) {
    return BrandEntityImpl(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      brandWebsite: brandWebsite ?? this.brandWebsite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'BrandEntityImpl(id: $id, name: $name, icon: $icon, color: $color, brandWebsite: $brandWebsite, createdAt: $createdAt)';
  }
}
