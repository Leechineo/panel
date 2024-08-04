import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

abstract class GetAllStocksUseCase {
  Future<List<StockEntity>> call({bool refresh = false});
}
