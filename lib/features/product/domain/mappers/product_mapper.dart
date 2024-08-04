import 'package:leechineo_panel/core/domain/mappers/app_mapper.dart';
import 'package:leechineo_panel/features/product/domain/dtos/product_dto.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

abstract class ProductMapper extends AppMapper<ProductDTO, ProductEntity> {}
