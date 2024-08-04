import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/components/address_selector_page/address_selector_tile.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector_page/address_selector_page_controller.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';

class AddressSelectorPage extends StatelessWidget {
  final AddressSelectorPageController controller;
  final void Function()? onAddAddressRequested;
  const AddressSelectorPage({
    required this.controller,
    this.onAddAddressRequested,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(builder: (context, data) {
      if (data.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (data.addresses.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppIlustration(
                AppIlustrations.locationReview,
                width: 200,
              ),
              const SizedBox(
                height: 12,
              ),
              FilledButton(
                onPressed: () {
                  onAddAddressRequested?.call();
                },
                child: const Text('Adicionar endereço'),
              ),
            ],
          ),
        );
      }
      return ListView.separated(
        itemBuilder: (context, index) => AddressSelectorTile(
          address: data.addresses[index],
          onToggleSelection: (address) {
            controller.methods.toogleAddresSelection(address);
          },
          selected: data.selectedAddresses.contains(
            data.addresses[index],
          ),
        ),
        separatorBuilder: (context, index) => const AppDivider(),
        itemCount: data.addresses.length,
      );
    });
  }
}
