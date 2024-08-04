import 'package:leechineo_panel/features/brand/domain/dtos/brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/create_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/update_brand_dto.dart';

abstract class BrandDatasource {
  Future<BrandDTO> createBrand(CreateBrandDTO brandData);
  Future<BrandDTO> getBrandById(String brandId);
  Future<BrandDTO> updateBrand(UpdateBrandDTO brandData);
  Future<BrandDTO> deleteBrand(String brandId);
  Future<List<BrandDTO>> getAllBrands({bool refresh = false});
}
