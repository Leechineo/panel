import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/repositories/brand_repository.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/delete_brand_usecase.dart';

class DeleteBrandUseCaseImpl implements DeleteBrandUseCase {
  final BrandRepository _brandRepository;

  DeleteBrandUseCaseImpl(this._brandRepository);

  @override
  Future<BrandEntity> call(String brandId) async {
    final deletedBrand = await _brandRepository.deleteBrand(brandId);
    return deletedBrand;
  }
}
