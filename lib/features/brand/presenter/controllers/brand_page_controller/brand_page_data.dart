import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

class BrandPageData {
  final List<BrandEntity> brands;

  final bool loading;

  BrandPageData({
    required this.brands,
    required this.loading,
  });

  BrandPageData copyWith({
    List<BrandEntity>? brands,
    bool? loading,
  }) {
    return BrandPageData(
      brands: brands ?? this.brands,
      loading: loading ?? this.loading,
    );
  }
}
