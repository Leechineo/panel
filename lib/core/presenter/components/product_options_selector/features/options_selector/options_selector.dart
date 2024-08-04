import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/options_selector/options_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/product_variant_selector/product_variant_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/widgets/product_selector_tile.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/domain/entities/order_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/stock/domain/usecases/get_all_stocks_usecase.dart';

class OptionsSelector extends StatelessWidget {
  final OptionsSelectorController controller;
  final void Function(
    ProductVariantsOption option,
    double quantity,
    ProductEntity product,
    ProductStock stock,
    CurrencyEnum currency,
  ) onOptionSelected;
  final List<OrderItem> selectedItems;
  final GetFileUrlUseCase getFileUrlUseCase;
  final GetAllStocksUseCase getAllStocksUseCase;
  const OptionsSelector({
    required this.controller,
    required this.onOptionSelected,
    required this.selectedItems,
    required this.getFileUrlUseCase,
    required this.getAllStocksUseCase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(
      builder: (context, data) {
        if (data.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (data.products.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppIlustration(
                AppIlustrations.shoppingBags,
                width: 200,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Sem produtos',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 12,
              ),
              FilledButton(
                //TODO push add product page
                onPressed: () {},
                child: const Text(
                  'Adicionar produto',
                ),
              ),
            ],
          );
        }
        return ListView.separated(
          itemBuilder: (context, index) => ProductSelectorTile(
            onOptionSelected: (option) {
              onOptionSelected(
                option['option'],
                option['quantity'],
                data.products[index],
                option['stock'],
                option['currency'],
              );
            },
            selectedItems: selectedItems
                .where((item) => item.id == data.products[index].id)
                .toList(),
            product: data.products[index],
            productVariantSelectorController: ProductVariantSelectorController(
              product: data.products[index],
              getAllStocksUseCase: getAllStocksUseCase,
            ),
            getFileUrlUseCase: getFileUrlUseCase,
          ),
          separatorBuilder: (context, index) => const AppDivider(),
          itemCount: data.products.length,
        );
      },
    );
  }
}
