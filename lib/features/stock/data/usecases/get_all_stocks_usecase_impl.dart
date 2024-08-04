import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/repositories/stock_repository.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/get_all_stocks_usecase.dart';

class GetAllStocksUseCaseImpl implements GetAllStocksUseCase {
  late final StockRepository _stockRepository;

  GetAllStocksUseCaseImpl(StockRepository stockRepository) {
    _stockRepository = stockRepository;
  }

  @override
  Future<List<StockEntity>> call({bool refresh = false}) async {
    final stocks = await _stockRepository.getAllStocks(refresh: refresh);
    return stocks;
  }
}
