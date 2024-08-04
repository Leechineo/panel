import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';

class SelectedOptionsMethods {
  final void Function(List<OrderItemImpl> items) setProductsFromSelectedItems;
  final Future<void> Function({
    DataRequest? dataRequest,
  }) loadProducts;
  SelectedOptionsMethods({
    required this.setProductsFromSelectedItems,
    required this.loadProducts,
  });
}
