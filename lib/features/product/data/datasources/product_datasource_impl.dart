import 'package:leechineo_panel/core/data/entities/pagination_entity_impl.dart';
import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/datasources/app_datasource.dart';
import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/product/data/models/product_model.dart';
import 'package:leechineo_panel/features/product/domain/datasources/product_datasource.dart';
import 'package:leechineo_panel/features/product/domain/dtos/create_product_dto.dart';
import 'package:leechineo_panel/features/product/domain/dtos/update_product_dto.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class ProductDatasouceImpl extends AppDatasource implements ProductDatasource {
  late final HttpAdapter _httpAdapter;

  ProductDatasouceImpl({
    required HttpAdapter httpAdapter,
  }) {
    _httpAdapter = httpAdapter;
  }
  @override
  Future<ProductEntity> createProduct(CreateProductDTO productData) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductEntity> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductEntity> getProductById(int id) async {
    final product = await exec<ProductEntity>(() async {
      final response = await _httpAdapter.get('/products/$id');
      final product = ProductModel.fromJson(response.data);
      return product;
    });
    return product;
  }

  @override
  Future<PaginatedResultOutput<ProductEntity>> loadProducts({
    DataRequest? dataRequest,
  }) async {
    final dataRequest0 = dataRequest ??
        DataRequest(
          paginationArgs: PaginationArgsImpl(
            limit: 10,
            page: 1,
          ),
        );
    final paginatedProduct = exec<PaginatedResultOutput<ProductEntity>>(
      () async {
        final response = await _httpAdapter.get(
          '/products',
          params: dataRequest0.queryParams(),
        );
        return PaginatedResultOutput(
          items: (response.data['items'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList(),
          total: response.data['total'],
        );
      },
    );
    return paginatedProduct;
  }

  @override
  Future<ProductEntity> updateProduct(UpdateProductDTO productData) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
