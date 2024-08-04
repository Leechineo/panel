import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/components/product_variant_selector/compound_variant_selector.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/components/product_variant_selector/simple_variant_selector.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/product_variant_selector/product_variant_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/widgets/product_variants_option_tile.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/domain/entities/order_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/product/domain/enums/product_variants_type_enum.dart';

class ProductVariantSelectorDialog extends StatelessWidget {
  final ProductVariantSelectorController controller;
  final List<OrderItem> selectedItems;
  final GetFileUrlUseCase getFileUrlUseCase;
  const ProductVariantSelectorDialog({
    required this.controller,
    required this.selectedItems,
    required this.getFileUrlUseCase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(builder: (context, data) {
      final ProductStock? selectedProductStock = data.selectedStock != null
          ? controller.methods.getProductStockFromStock(data.selectedStock!)
          : null;
      final ProductVariantsTypeEnum? selectedVariantType =
          data.selectedStock != null
              ? controller.methods
                  .getProductStockFromStock(data.selectedStock!)
                  .variants
                  .type
              : null;
      if (data.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      final double availableQuantity = controller.methods.getAvailableQuantity(
        data.selectedOption,
        selectedItems,
      );
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppCard(
                contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                height: 320,
                width: 650,
                titleText: 'Selecionar variante',
                child: Column(
                  children: [
                    DropdownButtonFormField(
                      items: controller.methods
                          .getStocksFromProduct()
                          .map(
                            (stock) => DropdownMenuItem(
                              value: stock.id,
                              child: Text(stock.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null && value != data.selectedStock?.id) {
                          controller.methods.updateSelectedStock(value);
                          controller.methods.updateSelectedVariantsOption(null);
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Estoque',
                        isDense: true,
                      ),
                      value: data.selectedStock?.id,
                    ),
                    if (selectedProductStock != null &&
                        selectedVariantType != ProductVariantsTypeEnum.unique)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: AppDivider(),
                      ),
                    if (data.selectedStock == null)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppIlustration(
                              AppIlustrations.containerShip,
                              width: 200,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Selecione um estoque',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    if (selectedVariantType == ProductVariantsTypeEnum.unique)
                      Builder(
                        builder: (context) {
                          if (data.selectedOption == null) {
                            controller.methods.updateSelectedVariantsOption(
                              selectedProductStock!.variants.option,
                            );
                          }
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AppIlustration(
                                  AppIlustrations.orderDelivered,
                                  height: 120,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Variante única',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    if (selectedVariantType == ProductVariantsTypeEnum.simple)
                      SimpleVariantSelector(
                        variants: selectedProductStock!.variants,
                        onSelected: (option) {
                          controller.methods
                              .updateSelectedVariantsOption(option);
                        },
                      ),
                    if (selectedVariantType == ProductVariantsTypeEnum.compound)
                      CompoundVariantSelector(
                        controller:
                            controller.compoundVariantSelectorController!,
                        onOptionSelected: (option) {
                          controller.methods
                              .updateSelectedVariantsOption(option);
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              AppCard(
                titleText: 'Variante selecionada',
                height: 320,
                width: 400,
                contentPadding: const EdgeInsets.all(12),
                child: Builder(builder: (context) {
                  if (data.selectedOption == null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppIlustration(
                          AppIlustrations.choose,
                          height: 120,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Nenhuma variante selecionada',
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    );
                  }
                  return ProductVariantsOptionTile(
                    option: data.selectedOption!,
                    type: selectedVariantType!,
                    currency: data.selectedStock!.currency,
                    getFileUrlUseCase: getFileUrlUseCase,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          AppCard(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            width: 1060,
            childExpanded: data.selectedOption != null,
            actions: [
              FilledButton(
                onPressed: data.selectedOption != null && availableQuantity > 0
                    ? () {
                        Navigator.pop<Map<String, dynamic>>(
                          context,
                          {
                            'option': data.selectedOption,
                            'quantity': data.quantity,
                            'stock': selectedProductStock!,
                            'currency': data.selectedStock!.currency,
                          },
                        );
                        controller.methods.updateSelectedVariantsOption(null);
                        controller.methods.updateSelectedStock(null);
                      }
                    : null,
                child: const Text(
                  'Confirmar',
                ),
              ),
              FilledButton(
                onPressed: () {
                  controller.methods.updateSelectedVariantsOption(null);
                  controller.methods.updateSelectedStock(null);
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Builder(
                  builder: (context) {
                    if (availableQuantity < 1) {
                      return Row(
                        children: [
                          Text(
                            'Sem estoque disponível',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.inventory_2_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      );
                    }
                    if (availableQuantity == 1 && data.selectedOption != null) {
                      return Row(
                        children: [
                          Text(
                            'Apenas uma variante disponível',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.check_circle_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      );
                    }
                    if (data.selectedOption != null) {
                      return Expanded(
                        child: Row(
                          children: [
                            const Text('Quantidade:'),
                            Expanded(
                              child: Slider(
                                value: data.quantity,
                                min: 1,
                                max: availableQuantity.toDouble(),
                                onChanged: (value) {
                                  controller.methods.updateQuantity(value);
                                },
                              ),
                            ),
                            Text(
                              '${data.quantity.round()} de ${availableQuantity.round()} disponíveis',
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
