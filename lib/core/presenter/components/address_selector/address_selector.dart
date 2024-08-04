import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/components/address_selector_dialog.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/components/address_selector_page/address_selector_tile.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector/address_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';

class AddressSelector extends StatelessWidget {
  final AddressSelectorController controller;
  final Widget Function(
    BuildContext context,
    Future<List<AddressEntityImpl>?> Function() selector,
  )? builder;
  final double? width;
  final double? height;
  final Function(List<AddressEntity>? addresses)? onAddressesSelected;
  const AddressSelector({
    required this.controller,
    this.onAddressesSelected,
    this.width,
    this.height,
    this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<List<AddressEntityImpl>?> selector() async {
      return await showDialog<List<AddressEntityImpl>>(
        context: context,
        builder: (context) => AddressSelectorDialog(
          controller: controller,
        ),
      );
    }

    return controller.addressSelectorPageController.builder(
      builder: (context, data) {
        return builder?.call(context, selector) ??
            AppCard(
              width: width,
              height: height,
              contentPadding: const EdgeInsets.all(12),
              actions: [
                FilledButton(
                  onPressed: data.user.id.isEmpty
                      ? null
                      : () async {
                          final addresses = await selector();
                          onAddressesSelected?.call(addresses);
                          if (addresses != null) {
                            controller.methods.setAddresses(addresses);
                          }
                        },
                  child: const Text(
                    'Selecionar endereço',
                  ),
                ),
              ],
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controller.builder(
                      builder: (context, data) {
                        if (data.addresses.isNotEmpty) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AppIlustration(
                                AppIlustrations.locationReview,
                                width: 100,
                              ),
                              AddressSelectorTile(
                                address: data.addresses[0],
                              ),
                            ],
                          );
                        }
                        return const AppIlustration(
                          AppIlustrations.mapDark,
                          width: 200,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (data.user.id.isEmpty)
                      Text(
                        'Selecione o usuário primeiro',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                  ],
                ),
              ),
            );
      },
    );
  }
}
