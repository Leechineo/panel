import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/components/option_manager_tile.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/selected_options/presentation/controllers/option_manager/option_manager_controller.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/data/entities/order_entity_impl.dart';

class OptionsManagerDialog extends StatefulWidget {
  final OptionManagerController controller;
  final void Function(OrderItemImpl item) onDeleted;
  final void Function(List<OrderItemImpl> items) onSaved;
  final GetFileUrlUseCase getFileUrlUseCase;
  const OptionsManagerDialog({
    required this.controller,
    required this.onDeleted,
    required this.onSaved,
    required this.getFileUrlUseCase,
    super.key,
  });

  @override
  State<OptionsManagerDialog> createState() => _OptionsManagerDialogState();
}

class _OptionsManagerDialogState extends State<OptionsManagerDialog> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.builder(
      builder: (context, data) {
        if (data.items.isEmpty) {
          return Container();
        }
        return AppCard(
          width: 900,
          height: 350,
          titleText: data.items[0].name,
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
            FilledButton(
              onPressed: () {
                widget.onSaved(data.items);
                Navigator.pop(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: AppFlex(
                wrap: true,
                maxItemsPerRow: 2,
                children: data.items.map(
                  (item) {
                    final int originalItemIndex =
                        widget.controller.items.indexWhere(
                      (element) => element.option.id == item.option.id,
                    );
                    return OptionManagerTile(
                      onDeleted: (item) {
                        widget.onDeleted(item);
                        widget.controller.methods.deleteItem(item);
                      },
                      item: item,
                      originalItem: originalItemIndex == -1
                          ? item.copyWith()
                          : widget.controller.items[originalItemIndex],
                      onUpdated: (item) {
                        widget.controller.methods.updateItem(item);
                      },
                      getFileUrlUseCase: widget.getFileUrlUseCase,
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        );
      },
      eventListener: (context, event, data) {
        if (event.id == 'itemRemoved') {
          if (data.items.isEmpty) {
            Navigator.maybePop(context);
          }
        }
      },
    );
  }
}
