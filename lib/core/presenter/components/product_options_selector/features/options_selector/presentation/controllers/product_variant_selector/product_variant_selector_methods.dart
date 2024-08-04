import 'package:leechineo_panel/features/order/domain/entities/order_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

class ProductVariantSelectorMethods {
  final Future<void> Function() loadStocks;
  final List<StockEntity> Function() getStocksFromProduct;
  final StockEntity? Function(String? stockId) updateSelectedStock;
  final ProductStock Function(StockEntity stock) getProductStockFromStock;
  final void Function(ProductVariantsOption? option)
      updateSelectedVariantsOption;
  final void Function() setCompoundVariantSelectorController;
  final void Function(double quantity) updateQuantity;
  final double Function(
          ProductVariantsOption? option, List<OrderItem> selectedItems)
      getAvailableQuantity;
  ProductVariantSelectorMethods({
    required this.loadStocks,
    required this.getStocksFromProduct,
    required this.updateSelectedStock,
    required this.getProductStockFromStock,
    required this.updateSelectedVariantsOption,
    required this.setCompoundVariantSelectorController,
    required this.updateQuantity,
    required this.getAvailableQuantity,
  });
}
