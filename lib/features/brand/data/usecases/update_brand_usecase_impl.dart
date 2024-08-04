import 'package:leechineo_panel/features/brand/domain/dtos/update_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/repositories/brand_repository.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/update_brand_usecase.dart';

class UpdateBrandUseCaseImpl implements UpdateBrandUseCase {
  final BrandRepository _brandRepository;

  UpdateBrandUseCaseImpl(this._brandRepository);

  @override
  Future<BrandEntity> call(UpdateBrandDTO brandData) async {
    final updatedBrand = await _brandRepository.updateBrand(brandData);
    return updatedBrand;
  }
}
