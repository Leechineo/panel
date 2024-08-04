import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/product/domain/dtos/create_product_dto.dart';
import 'package:leechineo_panel/features/product/domain/dtos/update_product_dto.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

abstract class ProductDatasource {
  Future<PaginatedResultOutput<ProductEntity>> loadProducts({
    DataRequest? dataRequest,
  });
  Future<ProductEntity> getProductById(int id);
  Future<ProductEntity> createProduct(CreateProductDTO productData);
  Future<ProductEntity> updateProduct(UpdateProductDTO productData);
  Future<ProductEntity> deleteProduct(int id);
}
