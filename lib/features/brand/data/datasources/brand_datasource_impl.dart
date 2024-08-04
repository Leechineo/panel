import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/datasources/app_datasource.dart';
import 'package:leechineo_panel/features/brand/domain/datasources/brand_datasource.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/create_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/dtos/update_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/brand_dto_mapper.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/create_brand_dto_mapper.dart';
import 'package:leechineo_panel/features/brand/domain/mappers/update_brand_dto_mapper.dart';

class BrandDatasourceImpl extends AppDatasource implements BrandDatasource {
  final HttpAdapter _httpAdapter;
  final BrandDTOMapper _brandDTOMapper;
  final CreateBrandDTOMapper _createBrandDTOMapper;
  final UpdateBrandDTOMapper _updateBrandDTOMapper;

  List<BrandDTO> currentBrands = [];

  BrandDatasourceImpl({
    required HttpAdapter httpAdapter,
    required BrandDTOMapper brandDTOMapper,
    required CreateBrandDTOMapper createBrandDTOMapper,
    required UpdateBrandDTOMapper updateBrandDTOMapper,
  })  : _httpAdapter = httpAdapter,
        _brandDTOMapper = brandDTOMapper,
        _createBrandDTOMapper = createBrandDTOMapper,
        _updateBrandDTOMapper = updateBrandDTOMapper;

  @override
  Future<BrandDTO> createBrand(CreateBrandDTO brandData) async {
    final createdBrand = await exec<BrandDTO>(() async {
      final response = await _httpAdapter.post(
        '/brands/',
        data: _createBrandDTOMapper.fromDTOToMap(brandData),
      );
      final createdBrand = _brandDTOMapper.fromMapToDTO(response.data);
      return createdBrand;
    });
    await getAllBrands(refresh: true);
    return createdBrand;
  }

  @override
  Future<BrandDTO> deleteBrand(String brandId) async {
    final deleted = await exec<BrandDTO>(() async {
      final response = await _httpAdapter.delete(
        '/brands/$brandId',
      );
      final deletedBrand = _brandDTOMapper.fromMapToDTO(response.data);
      return deletedBrand;
    });
    await getAllBrands(refresh: true);
    return deleted;
  }

  @override
  Future<List<BrandDTO>> getAllBrands({bool refresh = false}) async {
    final brands = await exec<List<BrandDTO>>(() async {
      if (currentBrands.isEmpty || refresh) {
        final response = await _httpAdapter.get('/brands/');
        currentBrands = (response.data as List)
            .map(
              (e) => _brandDTOMapper.fromMapToDTO(e),
            )
            .toList();
      }
      return currentBrands;
    });
    return brands;
  }

  @override
  Future<BrandDTO> getBrandById(String brandId) async {
    final brand = await exec<BrandDTO>(() async {
      if (currentBrands.any((element) => element.id == brandId)) {
        return currentBrands.firstWhere((element) => element.id == brandId);
      }
      final response = await _httpAdapter.get('/brands/$brandId');
      final brand = _brandDTOMapper.fromMapToDTO(response.data);
      return brand;
    });
    return brand;
  }

  @override
  Future<BrandDTO> updateBrand(UpdateBrandDTO brandData) async {
    final updatedBrand = await exec<BrandDTO>(() async {
      final response = await _httpAdapter.patch(
        '/brands/${brandData.id}',
        data: _updateBrandDTOMapper.fromDTOToMap(brandData),
      );
      final updatedBrand = _brandDTOMapper.fromMapToDTO(response.data);
      return updatedBrand;
    });
    await getAllBrands(refresh: true);
    return updatedBrand;
  }
}
