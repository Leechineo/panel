import 'package:leechineo_panel/core/presenter/components/product_options_selector/domain/entities/option_shipping_entitiy.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/entities/shipping_method_entity_impl.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

class ProductSelectorData {
  final List<OrderItemImpl> selectedItems;
  final List<StockEntity> stocks;
  final List<ShippingMethodEntityImpl> shippingMethods;
  final String? addressId;
  final List<OptionShippingEntity> productShippingMappings;
  final List<OptionShippingEntity> stockShippingMappings;
  ProductSelectorData({
    required this.selectedItems,
    required this.stocks,
    required this.shippingMethods,
    required this.addressId,
    required this.productShippingMappings,
    required this.stockShippingMappings,
  });

  ProductSelectorData copyWith({
    List<OrderItemImpl>? selectedItems,
    List<StockEntity>? stocks,
    List<ShippingMethodEntityImpl>? shippingMethods,
    String? addressId,
    List<OptionShippingEntity>? productShippingMappings,
    List<OptionShippingEntity>? stockShippingMappings,
  }) {
    return ProductSelectorData(
      selectedItems: selectedItems ?? this.selectedItems,
      stocks: stocks ?? this.stocks,
      shippingMethods: shippingMethods ?? this.shippingMethods,
      addressId: addressId ?? this.addressId,
      productShippingMappings:
          productShippingMappings ?? this.productShippingMappings,
      stockShippingMappings:
          stockShippingMappings ?? this.stockShippingMappings,
    );
  }
}
