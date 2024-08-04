import 'package:leechineo_panel/features/brand/domain/dtos/update_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

abstract class UpdateBrandUseCase {
  Future<BrandEntity> call(UpdateBrandDTO brandData);
}
