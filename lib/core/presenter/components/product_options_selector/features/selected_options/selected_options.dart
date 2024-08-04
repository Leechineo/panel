import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/controllers/selected_options/selected_options_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/widgets/selected_option_product_tile.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';

class SelectedOptionsPage extends StatelessWidget {
  final List<OrderItemImpl> items;
  final SelectedOptionsController controller;
  final void Function(OrderItemImpl item) onDeleted;
  final void Function(List<OrderItemImpl> items) onSaved;
  final GetFileUrlUseCase getFileUrlUseCase;
  const SelectedOptionsPage({
    required this.items,
    required this.controller,
    required this.onDeleted,
    required this.onSaved,
    required this.getFileUrlUseCase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    controller.methods.setProductsFromSelectedItems(items);
    if (items.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIlustration(
            AppIlustrations.selectOption,
            width: 200,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Nenhuma opção selecionada',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      );
    }
    return controller.builder(
      builder: (context, data) {
        return ListView.separated(
          itemBuilder: (context, index) => SelectedOptionProductTile(
            product: data.selectedProducts[index],
            selectedItems: items,
            onDeleted: (item) => onDeleted(item),
            onSaved: (items) => onSaved(items),
            getFileUrlUseCase: getFileUrlUseCase,
          ),
          separatorBuilder: (context, index) => const AppDivider(),
          itemCount: data.selectedProducts.length,
        );
      },
    );
  }
}
