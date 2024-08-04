import 'package:leechineo_panel/features/brand/domain/dtos/create_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/update_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

abstract class BrandRepository {
  Future<BrandEntity> createBrand(CreateBrandDTO brandData);
  Future<BrandEntity> getBrandById(String brandId);
  Future<BrandEntity> updateBrand(UpdateBrandDTO brandData);
  Future<BrandEntity> deleteBrand(String brandId);
  Future<List<BrandEntity>> getAllBrands({bool refresh = false});
}
