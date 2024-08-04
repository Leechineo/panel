import 'package:leechineo_panel/features/stock/domain/dtos/create_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/repositories/stock_repository.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/create_stock_usecase.dart';

class CreateStockUseCaseImpl implements CreateStockUseCase {
  late final StockRepository _stockRepository;

  CreateStockUseCaseImpl(StockRepository stockRepository) {
    _stockRepository = stockRepository;
  }
  @override
  Future<StockEntity> call(CreateStockDTO stockData) async {
    final stockCreated = await _stockRepository.createStock(stockData);
    return stockCreated;
  }
}
