import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

abstract class GetBrandByIdUseCase {
  Future<BrandEntity> call(String brandId);
}
