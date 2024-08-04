import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

abstract class GetProductsUseCase {
  Future<PaginatedResultOutput<ProductEntity>> call({
    DataRequest? dataRequest,
  });
}
