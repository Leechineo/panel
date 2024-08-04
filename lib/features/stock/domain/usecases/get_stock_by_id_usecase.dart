import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

abstract class GetStockByIdUseCase {
  Future<StockEntity> call(String stockId);
}
