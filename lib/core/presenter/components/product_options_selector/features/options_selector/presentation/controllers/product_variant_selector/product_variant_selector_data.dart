import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

class ProductVariantSelectorData {
  final bool loading;
  final List<StockEntity> stocks;
  final StockEntity? selectedStock;
  final ProductVariantsOption? selectedOption;
  final double quantity;

  ProductVariantSelectorData({
    required this.loading,
    required this.stocks,
    required this.selectedStock,
    required this.selectedOption,
    required this.quantity,
  });

  ProductVariantSelectorData copyWith({
    bool? loading,
    List<StockEntity>? stocks,
    StockEntity? selectedStock,
    ProductVariantsOption? selectedOption,
    bool? clearOption,
    bool? clearStock,
    double? quantity,
  }) {
    return ProductVariantSelectorData(
      loading: loading ?? this.loading,
      stocks: stocks ?? this.stocks,
      quantity: quantity ?? this.quantity,
      selectedStock: clearStock != null && clearStock
          ? null
          : selectedStock ?? this.selectedStock,
      selectedOption: clearOption != null && clearOption
          ? null
          : selectedOption ?? this.selectedOption,
    );
  }
}
