import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/repositories/stock_repository.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/get_stock_by_id_usecase.dart';

class GetStockByIdUseCaseImpl implements GetStockByIdUseCase {
  late final StockRepository _stockRepository;

  GetStockByIdUseCaseImpl(final StockRepository stockRepository) {
    _stockRepository = stockRepository;
  }
  @override
  Future<StockEntity> call(String stockId) async {
    final stock = await _stockRepository.getStockById(stockId);
    return stock;
  }
}
