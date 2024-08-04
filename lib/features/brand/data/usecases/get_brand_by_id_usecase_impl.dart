import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/repositories/brand_repository.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/get_brand_by_id_usecase.dart';

class GetBrandByIdUseCaseImpl implements GetBrandByIdUseCase {
  final BrandRepository _brandRepository;

  GetBrandByIdUseCaseImpl(this._brandRepository);

  @override
  Future<BrandEntity> call(String brandId) async {
    final brand = await _brandRepository.getBrandById(brandId);
    return brand;
  }
}
