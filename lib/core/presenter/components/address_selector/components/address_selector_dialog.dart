import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector/address_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/pages/address_creator.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/pages/address_selector_page.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';

class AddressSelectorDialog extends StatefulWidget {
  final AddressSelectorController controller;
  const AddressSelectorDialog({
    required this.controller,
    super.key,
  });

  @override
  State<AddressSelectorDialog> createState() => _AddressSelectorDialogState();
}

class _AddressSelectorDialogState extends State<AddressSelectorDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppCard(
        width: 1000,
        height: 450,
        title: TabBar(
          dividerColor: Colors.transparent,
          labelPadding: const EdgeInsets.all(12),
          controller: _tabController,
          tabs: const [
            Text('Edereçoes do usuário'),
            Text('Criar novo endereço'),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Fechar'),
          ),
          widget.controller.addressSelectorPageController.builder(
            builder: (context, data) {
              return FilledButton(
                onPressed: data.selectedAddresses.isEmpty
                    ? null
                    : () {
                        Navigator.pop<List<AddressEntity>>(
                            context, data.selectedAddresses);
                      },
                child: const Text('Concluir'),
              );
            },
          ),
        ],
        child: TabBarView(
          controller: _tabController,
          children: [
            AddressSelectorPage(
              controller: widget.controller.addressSelectorPageController,
              onAddAddressRequested: () {
                _tabController.animateTo(1);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AddressCreator(
                controller: widget.controller.addressCreatorController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
