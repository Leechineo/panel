import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';

class OptionManagerData {
  final List<OrderItemImpl> items;
  OptionManagerData({
    required this.items,
  });

  OptionManagerData copyWith({
    List<OrderItemImpl>? items,
  }) {
    return OptionManagerData(
      items: items ?? this.items,
    );
  }
}
