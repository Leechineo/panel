import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/components/product_variant_selector/product_variant_selector_dialog.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/product_variant_selector/product_variant_selector_controller.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/domain/entities/order_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class ProductSelectorTile extends StatelessWidget {
  final ProductEntity product;
  final ProductVariantSelectorController productVariantSelectorController;
  final List<OrderItem> selectedItems;
  final void Function(Map<String, dynamic> option) onOptionSelected;
  final GetFileUrlUseCase getFileUrlUseCase;
  const ProductSelectorTile({
    required this.product,
    required this.productVariantSelectorController,
    required this.onOptionSelected,
    required this.selectedItems,
    required this.getFileUrlUseCase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool multipleVariants = selectedItems.length > 1;
    return InkWell(
      onTap: () async {
        final Map<String, dynamic>? option =
            await showDialog<Map<String, dynamic>>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(
              child: ProductVariantSelectorDialog(
                controller: productVariantSelectorController,
                selectedItems: selectedItems,
                getFileUrlUseCase: getFileUrlUseCase,
              ),
            );
          },
        );
        if (option != null) {
          onOptionSelected(option);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            AnimatedOpacity(
              opacity: selectedItems.isNotEmpty ? 1 : 0,
              duration: const Duration(
                milliseconds: 80,
              ),
              child: Tooltip(
                message:
                    '${selectedItems.length} ${multipleVariants ? 'variantes' : 'variante'} ${multipleVariants ? 'selecionadas' : 'selecionada'}',
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 80,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(365),
                  ),
                  curve: Curves.easeInOut,
                  width: selectedItems.isNotEmpty ? 25 : 0,
                  child: Center(
                    child: Text(
                      selectedItems.length.toString(),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                getFileUrlUseCase(product.images[0]),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
