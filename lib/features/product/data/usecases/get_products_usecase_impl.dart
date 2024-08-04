import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/product/domain/repositories/product_repository.dart';
import 'package:leechineo_panel/features/product/domain/usecases/get_products_usecase.dart';

class GetProductsUseCaseImpl implements GetProductsUseCase {
  late final ProductRepository _productRepository;

  GetProductsUseCaseImpl({
    required ProductRepository productRepository,
  }) {
    _productRepository = productRepository;
  }

  @override
  Future<PaginatedResultOutput<ProductEntity>> call({
    DataRequest? dataRequest,
  }) async {
    final paginatedProducts = await _productRepository.loadProducts(
      dataRequest: dataRequest,
    );
    return paginatedProducts;
  }
}
