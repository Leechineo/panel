import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/controllers/option_manager/option_manager_data.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/controllers/option_manager/option_manager_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';

class OptionManagerController<V>
    extends AppController<OptionManagerData, OptionManagerMethods> {
  final List<OrderItemImpl> items;
  OptionManagerController({
    required this.items,
  });

  @override
  OptionManagerMethods defineMethods() {
    return OptionManagerMethods(
      updateItem: (item) {
        final itemsCopy = List<OrderItemImpl>.from(data.items);
        final indexToUpdate = itemsCopy.indexWhere(
          (element) => element.option.id == item.option.id,
        );
        if (indexToUpdate != -1) {
          itemsCopy[indexToUpdate] = item;
          updateData(
            data.copyWith(
              items: itemsCopy,
            ),
          );
        }
      },
      deleteItem: (item) {
        final selectedItemsCopy = List<OrderItemImpl>.from(data.items);
        final indexToRemove = selectedItemsCopy.indexWhere(
          (element) => element.option.id == item.option.id,
        );
        if (indexToRemove != -1) {
          selectedItemsCopy.removeAt(indexToRemove);
          updateData(
            data.copyWith(
              items: selectedItemsCopy,
            ),
          );
          dispatchEvent(
            AppControllerEvent(
              id: 'itemRemoved',
              data: data,
            ),
          );
        }
      },
    );
  }

  @override
  OptionManagerData defineData() {
    return OptionManagerData(
      items: items.map((e) => e.copyWith()).toList(),
    );
  }
}
