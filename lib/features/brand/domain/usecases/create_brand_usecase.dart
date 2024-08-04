import 'package:leechineo_panel/features/brand/domain/dtos/create_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

abstract class CreateBrandUseCase {
  Future<BrandEntity> call(CreateBrandDTO brandData);
}
