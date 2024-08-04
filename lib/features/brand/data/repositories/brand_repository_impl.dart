import 'package:leechineo_panel/features/brand/domain/datasources/brand_datasource.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/create_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/update_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_dto_mapper.dart';
import 'package:leechineo_panel/features/brand/domain/repositories/brand_repository.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandDatasource _brandDatasource;
  final BrandDTOMapper _brandDTOMapper;

  BrandRepositoryImpl(this._brandDatasource, this._brandDTOMapper);

  @override
  Future<BrandEntity> createBrand(CreateBrandDTO brandData) async {
    final createdBrand = await _brandDatasource.createBrand(brandData);
    return _brandDTOMapper.fromDTOToEntity(createdBrand);
  }

  @override
  Future<BrandEntity> deleteBrand(String brandId) async {
    final deletedBrand = await _brandDatasource.deleteBrand(brandId);
    return _brandDTOMapper.fromDTOToEntity(deletedBrand);
  }

  @override
  Future<List<BrandEntity>> getAllBrands({bool refresh = false}) async {
    final brands = await _brandDatasource.getAllBrands(refresh: refresh);
    return brands.map((e) => _brandDTOMapper.fromDTOToEntity(e)).toList();
  }

  @override
  Future<BrandEntity> getBrandById(String brandId) async {
    final brand = await _brandDatasource.getBrandById(brandId);
    return _brandDTOMapper.fromDTOToEntity(brand);
  }

  @override
  Future<BrandEntity> updateBrand(UpdateBrandDTO brandData) async {
    final updatedBrand = await _brandDatasource.updateBrand(brandData);
    return _brandDTOMapper.fromDTOToEntity(updatedBrand);
  }
}
