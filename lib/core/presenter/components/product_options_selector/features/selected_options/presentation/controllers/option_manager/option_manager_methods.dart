import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';

class OptionManagerMethods {
  final void Function(OrderItemImpl item) deleteItem;
  final void Function(OrderItemImpl item) updateItem;
  OptionManagerMethods({
    required this.deleteItem,
    required this.updateItem,
  });
}
