import 'package:leechineo_panel/features/brand/domain/dtos/create_brand_dto.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/repositories/brand_repository.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/create_brand_usecase.dart';

class CreateBrandUseCaseImpl implements CreateBrandUseCase {
  final BrandRepository _brandRepository;

  CreateBrandUseCaseImpl(this._brandRepository);

  @override
  Future<BrandEntity> call(CreateBrandDTO brandData) async {
    final createdBrand = _brandRepository.createBrand(brandData);
    return createdBrand;
  }
}
