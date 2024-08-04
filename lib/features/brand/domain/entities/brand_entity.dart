import 'package:flutter/material.dart';

class BrandColor {
  final Color light;
  final Color dark;

  BrandColor({
    required this.light,
    required this.dark,
  });

  BrandColor copyWith({
    Color? light,
    Color? dark,
  }) {
    return BrandColor(
      light: light ?? this.light,
      dark: dark ?? this.dark,
    );
  }

  @override
  String toString() => 'BrandColor(light: $light, dark: $dark)';
}

class BrandIcon {
  final String light;
  final String dark;

  BrandIcon({
    required this.light,
    required this.dark,
  });

  BrandIcon copyWith({
    String? light,
    String? dark,
  }) {
    return BrandIcon(
      light: light ?? this.light,
      dark: dark ?? this.dark,
    );
  }

  @override
  String toString() => 'BrandIcon(light: $light, dark: $dark)';
}

abstract class BrandEntity {
  final String id;
  final String name;
  final BrandIcon icon;
  final BrandColor color;
  final String brandWebsite;
  final DateTime createdAt;

  BrandEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.brandWebsite,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'BrandEntity(id: $id, name: $name, icon: $icon, color: $color, brandWebsite: $brandWebsite, createdAt: $createdAt)';
  }
}
