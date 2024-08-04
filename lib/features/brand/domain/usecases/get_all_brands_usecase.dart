import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';

abstract class GetAllBrandsUseCase {
  Future<List<BrandEntity>> call({bool refresh = false});
}
