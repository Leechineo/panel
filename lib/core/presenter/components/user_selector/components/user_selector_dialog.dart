import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector/user_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/pages/user_selector_page.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class UserSelectorDialog extends StatelessWidget {
  final UserSelectorController controller;
  const UserSelectorDialog({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppCard(
        width: 860,
        height: 350,
        title: SearchAnchor(
          suggestionsBuilder: (context, controller) {
            return [Container()];
          },
          builder: (context, controller) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
                onTap: () {
                  controller.openView();
                },
                leading: const Icon(
                  Icons.search_rounded,
                ),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                ),
                shadowColor: const MaterialStatePropertyAll(
                  Colors.transparent,
                ),
              ),
            );
          },
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          controller.userSelectorPageController.builder(
            builder: (context, data) {
              return FilledButton(
                onPressed: data.selectedUsers.isEmpty
                    ? null
                    : () {
                        Navigator.pop<List<UserEntityImpl>>(
                            context, data.selectedUsers);
                      },
                child: const Text('Concluir'),
              );
            },
          ),
        ],
        child: UserSelectorPage(
          controller: controller.userSelectorPageController,
        ),
      ),
    );
  }
}
