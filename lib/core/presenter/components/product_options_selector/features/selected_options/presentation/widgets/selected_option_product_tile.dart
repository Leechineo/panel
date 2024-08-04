import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/components/options_manager_dialog.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/controllers/option_manager/option_manager_controller.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class SelectedOptionProductTile extends StatelessWidget {
  final ProductEntity product;
  final List<OrderItemImpl> selectedItems;
  final void Function(OrderItemImpl item) onDeleted;
  final void Function(List<OrderItemImpl> items) onSaved;
  final GetFileUrlUseCase getFileUrlUseCase;
  const SelectedOptionProductTile({
    required this.product,
    required this.selectedItems,
    required this.onDeleted,
    required this.onSaved,
    required this.getFileUrlUseCase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<OrderItemImpl> filteredItems = selectedItems
        .where(
          (element) => element.id == product.id,
        )
        .toList();
    final bool multipleVariants = filteredItems.length > 1;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(
              child: OptionsManagerDialog(
                controller: OptionManagerController(
                  items: selectedItems
                      .where(
                        (item) => item.id == product.id,
                      )
                      .toList(),
                ),
                onDeleted: (item) => onDeleted(item),
                onSaved: (items) {
                  onSaved(items);
                },
                getFileUrlUseCase: getFileUrlUseCase,
              ),
            );
          },
        );
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
                    '${filteredItems.length} ${multipleVariants ? 'variantes' : 'variante'} ${multipleVariants ? 'selecionadas' : 'selecionada'}',
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
                      filteredItems.length.toString(),
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
