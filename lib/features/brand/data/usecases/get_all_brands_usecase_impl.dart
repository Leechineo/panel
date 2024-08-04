import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/domain/repositories/brand_repository.dart';
import 'package:leechineo_panel/features/brand/domain/usecases/get_all_brands_usecase.dart';

class GetAllBrandsUseCaseImpl implements GetAllBrandsUseCase {
  final BrandRepository _brandRepository;

  GetAllBrandsUseCaseImpl(this._brandRepository);

  @override
  Future<List<BrandEntity>> call({bool refresh = false}) async {
    final brands = await _brandRepository.getAllBrands(refresh: refresh);
    return brands;
  }
}
