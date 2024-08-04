import 'package:leechineo_panel/features/stock/domain/datasources/stock_datasorce.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/create_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/update_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';
import 'package:leechineo_panel/features/stock/domain/mappers/stock_dto_mapper.dart';
import 'package:leechineo_panel/features/stock/domain/repositories/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  late final StockDTOMapper _stockDTOMapper;
  late final StockDatasource _stockDatasource;

  StockRepositoryImpl(
    StockDatasource stockDatasource,
    StockDTOMapper stockDTOMapper,
  ) {
    _stockDatasource = stockDatasource;
    _stockDTOMapper = stockDTOMapper;
  }

  @override
  Future<StockEntity> createStock(CreateStockDTO stockData) async {
    final createdStock = await _stockDatasource.createStock(stockData);
    final entity = _stockDTOMapper.fromDTOToEntity(createdStock);
    return entity;
  }

  @override
  Future<StockEntity> deleteStock(String stockId) async {
    final deletedStock = await _stockDatasource.deleteStock(stockId);
    final entity = _stockDTOMapper.fromDTOToEntity(deletedStock);
    return entity;
  }

  @override
  Future<List<StockEntity>> getAllStocks({bool refresh = false}) async {
    final stocks = await _stockDatasource.getAllStocks(refresh: refresh);
    final entities = stocks.map((e) => _stockDTOMapper.fromDTOToEntity(e));
    return entities.toList();
  }

  @override
  Future<StockEntity> updateStock(UpdateStockDTO stockData) async {
    final updatedStock = await _stockDatasource.updateStock(stockData);
    final entity = _stockDTOMapper.fromDTOToEntity(updatedStock);
    return entity;
  }

  @override
  Future<StockEntity> getStockById(String stockId) async {
    final stock = await _stockDatasource.getStockById(stockId);
    final entity = _stockDTOMapper.fromDTOToEntity(stock);
    return entity;
  }
}
