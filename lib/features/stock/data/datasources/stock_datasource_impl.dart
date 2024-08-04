import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/datasources/app_datasource.dart';
import 'package:leechineo_panel/features/stock/domain/datasources/stock_datasorce.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/create_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/dtos/update_stock_dto.dart';
import 'package:leechineo_panel/features/stock/domain/mappers/create_stock_dto_mapper.dart';
import 'package:leechineo_panel/features/stock/domain/mappers/stock_dto_mapper.dart';
import 'package:leechineo_panel/features/stock/domain/mappers/update_stock_dto_mapper.dart';

class StockDatasourceImpl extends AppDatasource implements StockDatasource {
  late final HttpAdapter _httpAdapter;
  late final StockDTOMapper _stockDTOMapper;
  late final CreateStockDTOMapper _createStockDTOMapper;
  late final UpdateStockDTOMapper _updateStockDTOMapper;

  List<StockDTO> _currentStocks = [];

  StockDatasourceImpl(
    HttpAdapter httpAdapter,
    StockDTOMapper stockDTOMapper,
    CreateStockDTOMapper createStockDTOMapper,
    UpdateStockDTOMapper updateStockDTOMapper,
  ) {
    _httpAdapter = httpAdapter;
    _stockDTOMapper = stockDTOMapper;
    _createStockDTOMapper = createStockDTOMapper;
    _updateStockDTOMapper = updateStockDTOMapper;
  }

  @override
  Future<StockDTO> createStock(CreateStockDTO stockData) async {
    final createdStock = exec<StockDTO>(() async {
      final response = await _httpAdapter.post(
        '/stocks/',
        data: _createStockDTOMapper.fromDTOToMap(stockData),
      );
      final createdStock = _stockDTOMapper.fromMapToDTO(response.data);
      return createdStock;
    });
    return createdStock;
  }

  @override
  Future<StockDTO> deleteStock(String stockId) async {
    final deletedStock = exec<StockDTO>(() async {
      final response = await _httpAdapter.delete('/stocks/$stockId/');
      final deletedStock = _stockDTOMapper.fromMapToDTO(response.data);
      return deletedStock;
    });
    return deletedStock;
  }

  @override
  Future<List<StockDTO>> getAllStocks({bool refresh = false}) async {
    final stocks = await exec<List<StockDTO>>(() async {
      if (_currentStocks.isNotEmpty && !refresh) {
        return _currentStocks;
      }
      final response = await _httpAdapter.get('/stocks/');
      _currentStocks = (response.data as List)
          .map(
            (e) => _stockDTOMapper.fromMapToDTO(e),
          )
          .toList();
      return _currentStocks;
    });
    return stocks;
  }

  @override
  Future<StockDTO> updateStock(UpdateStockDTO stockData) {
    final updatedStock = exec<StockDTO>(() async {
      final response = await _httpAdapter.patch(
        '/stocks/${stockData.id}/',
        data: _updateStockDTOMapper.fromDTOToMap(stockData),
      );
      final updatedStock = _stockDTOMapper.fromMapToDTO(response.data);
      return updatedStock;
    });
    return updatedStock;
  }

  @override
  Future<StockDTO> getStockById(String stockId) async {
    final stock = exec<StockDTO>(() async {
      final response = await _httpAdapter.get('/stocks/$stockId/');
      final stock = _stockDTOMapper.fromMapToDTO(response.data);
      return stock;
    });
    return stock;
  }
}
