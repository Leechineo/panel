import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/product/domain/datasources/product_datasource.dart';
import 'package:leechineo_panel/features/product/domain/dtos/create_product_dto.dart';
import 'package:leechineo_panel/features/product/domain/dtos/update_product_dto.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  late final ProductDatasource _productDatasource;

  ProductRepositoryImpl({
    required ProductDatasource productDatasource,
  }) {
    _productDatasource = productDatasource;
  }

  @override
  Future<ProductEntity> createProduct(CreateProductDTO productData) async {
    final createdProduct = await _productDatasource.createProduct(productData);
    return createdProduct;
  }

  @override
  Future<ProductEntity> deleteProduct(int id) async {
    final deletedProduct = await _productDatasource.deleteProduct(id);
    return deletedProduct;
  }

  @override
  Future<ProductEntity> getProductById(int id) async {
    final product = await _productDatasource.getProductById(id);
    return product;
  }

  @override
  Future<PaginatedResultOutput<ProductEntity>> loadProducts({
    DataRequest? dataRequest,
  }) async {
    final paginatedProducts =
        await _productDatasource.loadProducts(dataRequest: dataRequest);
    return paginatedProducts;
  }

  @override
  Future<ProductEntity> updateProduct(UpdateProductDTO productData) async {
    final updatedProduct = await _productDatasource.updateProduct(productData);
    return updatedProduct;
  }
}
