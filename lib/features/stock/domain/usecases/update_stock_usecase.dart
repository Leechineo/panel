import 'package:leechineo_panel/features/stock/domain/dtos/update_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

abstract class UpdateStockUseCase {
  Future<StockEntity> call(UpdateStockDTO stock);
}
