import 'package:leechineo_panel/features/stock/domain/dtos/create_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/update_stock_dto.dart';

abstract class StockDatasource {
  Future<List<StockDTO>> getAllStocks({bool refresh = false});
  Future<StockDTO> getStockById(String stockId);
  Future<StockDTO> createStock(CreateStockDTO stock);
  Future<StockDTO> updateStock(UpdateStockDTO stock);
  Future<StockDTO> deleteStock(String stockId);
}
