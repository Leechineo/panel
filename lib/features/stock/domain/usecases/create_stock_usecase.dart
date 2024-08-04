import 'package:leechineo_panel/features/stock/domain/dtos/create_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

abstract class CreateStockUseCase {
  Future<StockEntity> call(CreateStockDTO stock);
}
