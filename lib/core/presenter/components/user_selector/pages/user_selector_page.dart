import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/components/user_selector_page/user_selector_tile.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector_page/user_selector_page_controller.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';

class UserSelectorPage extends StatelessWidget {
  final UserSelectorPageController controller;
  const UserSelectorPage({
    required this.controller,
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
        return ListView.separated(
          itemBuilder: (context, index) => UserSelectorTile(
            onSelected: (user) {
              controller.methods.toggleSelection(user);
            },
            selected: data.selectedUsers.contains(
              data.users[index],
            ),
            user: data.users[index],
          ),
          separatorBuilder: (context, index) => const AppDivider(),
          itemCount: data.users.length,
        );
      },
      allowAlertDialog: true,
    );
  }
}
