import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

abstract class DeleteBrandUseCase {
  Future<BrandEntity> call(String brandId);
}
