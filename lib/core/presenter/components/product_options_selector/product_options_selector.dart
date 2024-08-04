import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/components/option_manager_tile.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/widgets/shipping_mapping_data.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/presentation/components/product_selector_dialog.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/presentation/controllers/product_options_selector/product_options_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';

class ProductSelector extends StatelessWidget {
  final ProductSelectorController controller;
  final double? width;
  final double? height;
  final GetFileUrlUseCase getFileUrlUseCase;
  const ProductSelector({
    required this.controller,
    required this.getFileUrlUseCase,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(
      builder: (context, data) {
        return AppCard(
          contentPadding: const EdgeInsets.all(12),
          titleText: 'Carrinho',
          actions: [
            FilledButton(
              onPressed: () async {
                await showDialog<List<OrderItemImpl>>(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: ProductSelectorDialog(
                        controller: controller,
                        getFileUrlUseCase: getFileUrlUseCase,
                      ),
                    );
                  },
                );
              },
              child: Text(
                data.selectedItems.isEmpty
                    ? 'Adicionar items'
                    : 'Gerenciar items',
              ),
            ),
          ],
          child: Center(
            child: Builder(
              builder: (context) {
                if (data.selectedItems.isEmpty) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppIlustration(
                        AppIlustrations.shoppingBags,
                        width: 200,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Nenhuma variante selecionada',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  );
                }
                return SingleChildScrollView(
                  child: AppFlex(
                    maxItemsPerRow: 1,
                    maxItemsPerRowMd: 2,
                    children: data.stocks.map(
                      (stock) {
                        final itemsFromStock = data.selectedItems
                            .where(
                              (element) => element.stockId == stock.id,
                            )
                            .toList();
                        return AppCard(
                          titleText: stock.name,
                          child: Builder(
                            builder: (context) {
                              final variantsWithoutShippingMehtod =
                                  itemsFromStock.where(
                                (element) =>
                                    controller.methods.findProductShipping(
                                      element.id,
                                      stock.shippingMethod,
                                    ) ==
                                    null,
                              );
                              final variantsWithShippingMethod = itemsFromStock
                                  .where(
                                    (element) => !variantsWithoutShippingMehtod
                                        .contains(element),
                                  )
                                  .toList();
                              final availableShippingMethods =
                                  variantsWithShippingMethod
                                      .map(
                                        (e) =>
                                            controller.methods
                                                .findProductShipping(
                                                  e.id,
                                                  stock.shippingMethod,
                                                )
                                                ?.shippingMethodId ??
                                            '',
                                      )
                                      .where((element) => element.isNotEmpty)
                                      .toSet()
                                      .toList();
                              return Column(
                                children: [
                                  Column(
                                    children: variantsWithoutShippingMehtod
                                        .map(
                                          (e) => OptionManagerTile(
                                            item: e,
                                            originalItem: e,
                                            onDeleted: (item) {},
                                            onUpdated: (item) {},
                                            expanded: false,
                                            shippingMapping: controller.methods
                                                .findProductShipping(
                                                  e.id,
                                                  stock.shippingMethod,
                                                )
                                                ?.shippingMethodMapping,
                                            getFileUrlUseCase:
                                                getFileUrlUseCase,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  Column(
                                    children: availableShippingMethods.map(
                                      (shippingMethodId) {
                                        final shippingMapping = controller
                                            .methods
                                            .findProductShipping(
                                          variantsWithShippingMethod.first.id,
                                          stock.shippingMethod,
                                        );
                                        return AppCard(
                                          title: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: ShippingMappingData(
                                              shippingMapping: shippingMapping,
                                            ),
                                          ),
                                          child: Column(
                                            children: variantsWithShippingMethod
                                                .where(
                                                  (element) =>
                                                      controller.methods
                                                          .findProductShipping(
                                                            element.id,
                                                            stock
                                                                .shippingMethod,
                                                          )
                                                          ?.shippingMethodId ==
                                                      shippingMethodId,
                                                )
                                                .map(
                                                  (e) => OptionManagerTile(
                                                    item: e,
                                                    originalItem: e,
                                                    onDeleted: (item) {},
                                                    onUpdated: (item) {},
                                                    expanded: false,
                                                    getFileUrlUseCase:
                                                        getFileUrlUseCase,
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                  if (controller.methods.findStockShipping(
                                        stock,
                                      ) !=
                                      null)
                                    const Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: AppDivider(),
                                    ),
                                  if (controller.methods.findStockShipping(
                                        stock,
                                      ) !=
                                      null)
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: ShippingMappingData(
                                        shippingMapping: controller.methods
                                            .findStockShipping(
                                          stock,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          // child: ListView.separated(
                          //   itemBuilder: (context, index) {
                          //     final shippingMethodMapping =
                          //         controller.methods.findProductShipping(
                          //       itemsFromStock[index].id,
                          //       stock.shippingMethod,
                          //     );
                          //     if (shippingMethodMapping != null) {
                          //       return const Text('teste do ${1 + 1}');
                          //     }
                          //     return OptionManagerTile(
                          //       item: itemsFromStock[index],
                          //       originalItem: itemsFromStock[index],
                          //       onDeleted: (item) {},
                          //       onUpdated: (item) {},
                          //       expanded: false,
                          //       shippingMapping: controller.methods
                          //           .findProductShipping(
                          //             itemsFromStock[index].id,
                          //             stock.shippingMethod,
                          //           )
                          //           ?.shippingMethodMapping,
                          //       getFileUrlUseCase: getFileUrlUseCase,
                          //     );
                          //   },
                          //   separatorBuilder: (context, index) {
                          //     return const AppDivider();
                          //   },
                          //   itemCount: itemsFromStock.length,
                          // ),
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            ),
          ),
        );
      },
      allowAlertDialog: true,
    );
  }
}
