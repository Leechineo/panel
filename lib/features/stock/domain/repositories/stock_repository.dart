import 'package:leechineo_panel/features/stock/domain/dtos/create_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/update_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

abstract class StockRepository {
  Future<List<StockEntity>> getAllStocks({bool refresh = false});
  Future<StockEntity> getStockById(String stockId);
  Future<StockEntity> createStock(CreateStockDTO stockData);
  Future<StockEntity> updateStock(UpdateStockDTO stockData);
  Future<StockEntity> deleteStock(String stockId);
}
