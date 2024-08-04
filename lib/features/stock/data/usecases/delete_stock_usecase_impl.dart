import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/repositories/stock_repository.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/delete_stock_usecase.dart';

class DeleteStockUsecaseImpl implements DeleteStockUseCase {
  late final StockRepository _stockRepository;

  DeleteStockUsecaseImpl(StockRepository stockRepository) {
    _stockRepository = stockRepository;
  }
  @override
  Future<StockEntity> call(String stockId) async {
    final deletedStock = await _stockRepository.deleteStock(stockId);
    return deletedStock;
  }
}
