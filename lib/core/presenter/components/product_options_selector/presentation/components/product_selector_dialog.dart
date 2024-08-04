import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/options_selector.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/controllers/selected_options/selected_options_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/selected_options.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/presentation/controllers/product_options_selector/product_options_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';
import 'package:leechineo_panel/features/order/domain/entities/order_entity.dart';

class ProductSelectorDialog extends StatefulWidget {
  final ProductSelectorController controller;
  final GetFileUrlUseCase getFileUrlUseCase;
  const ProductSelectorDialog({
    required this.controller,
    required this.getFileUrlUseCase,
    super.key,
  });

  @override
  State<ProductSelectorDialog> createState() => _ProductSelectorDialogState();
}

class _ProductSelectorDialogState extends State<ProductSelectorDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.builder(
      builder: (context, data) {
        return AppCard(
          width: 850,
          height: 370,
          title: TabBar(
            dividerColor: Colors.transparent,
            labelPadding: const EdgeInsets.all(12),
            splashBorderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            padding: const EdgeInsets.only(
              top: 4,
              left: 4,
              right: 4,
            ),
            controller: _tabController,
            tabs: const [
              Text(
                'Produtos',
              ),
              Text(
                'Selecionados',
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Fechar',
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop<List<OrderItem>>(context, data.selectedItems);
              },
              child: const Text(
                'Concluir',
              ),
            ),
          ],
          child: TabBarView(
            controller: _tabController,
            children: [
              OptionsSelector(
                controller: widget.controller.optionsSelectorController,
                selectedItems: data.selectedItems,
                onOptionSelected: (option, quantity, product, stock, currency) {
                  final item = OrderItemImpl.fromProductAndOption(
                    product: product,
                    option: option,
                    quantity: quantity.round(),
                    stock: stock,
                    currency: currency,
                  );
                  widget.controller.methods.addSelectedItem(item);
                },
                getFileUrlUseCase: widget.getFileUrlUseCase,
                getAllStocksUseCase: widget.controller.getAllStocksUseCase,
              ),
              SelectedOptionsPage(
                onDeleted: (item) => widget.controller.methods.deleteItem(item),
                items: data.selectedItems,
                controller: SelectedOptionsController(
                  getProductsUseCase: widget.controller.getProductsUseCase,
                  selectedItems: data.selectedItems,
                ),
                onSaved: (items) =>
                    widget.controller.methods.updateItems(items),
                getFileUrlUseCase: widget.getFileUrlUseCase,
              ),
            ],
          ),
        );
      },
    );
  }
}
