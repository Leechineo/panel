import 'package:leechineo_panel/features/stock/domain/dtos/update_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/repositories/stock_repository.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/update_stock_usecase.dart';

class UpdateStockUseCaseImpl implements UpdateStockUseCase {
  late final StockRepository _stockRepository;

  UpdateStockUseCaseImpl(StockRepository stockRepository) {
    _stockRepository = stockRepository;
  }
  @override
  Future<StockEntity> call(UpdateStockDTO stockData) async {
    final updatedStock = await _stockRepository.updateStock(stockData);
    return updatedStock;
  }
}
