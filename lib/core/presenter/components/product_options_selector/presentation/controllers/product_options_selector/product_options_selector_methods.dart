import 'package:leechineo_panel/core/presenter/components/product_options_selector/domain/entities/option_shipping_entitiy.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

class ProductSelectorMethods {
  final void Function(OrderItemImpl item) addSelectedItem;
  final void Function(OrderItemImpl item) deleteItem;
  final void Function(List<OrderItemImpl> items) updateItems;
  final Future<void> Function() updateStocks;
  final Future<void> Function() updateShippingMethods;
  final void Function(String? addressId) defineAddressId;
  final OptionShippingEntity? Function(
    int productId,
    String shippingMethodId,
  ) findProductShipping;
  final Future<void> Function() updadeShippingProductMappings;
  final Future<void> Function() updadeShippingMappings;
  final OptionShippingEntity? Function(
    StockEntity stock,
  ) findStockShipping;
  ProductSelectorMethods({
    required this.addSelectedItem,
    required this.deleteItem,
    required this.updateItems,
    required this.updateStocks,
    required this.updateShippingMethods,
    required this.defineAddressId,
    required this.findProductShipping,
    required this.updadeShippingProductMappings,
    required this.updadeShippingMappings,
    required this.findStockShipping,
  });
}
