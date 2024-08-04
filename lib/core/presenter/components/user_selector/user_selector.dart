import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/components/user_selector_dialog.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector/user_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class UserSelector extends StatelessWidget {
  final UserSelectorController controller;
  final Widget Function(
    BuildContext context,
    Future<List<UserEntityImpl>?> Function() selector,
  )? builder;
  final double? width;
  final double? height;

  final void Function(List<UserEntityImpl> users)? onUsersSelected;

  const UserSelector({
    required this.controller,
    this.width,
    this.height,
    this.builder,
    this.onUsersSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<List<UserEntityImpl>?> selector() async {
      return await showDialog(
        context: context,
        builder: (context) => UserSelectorDialog(
          controller: controller,
        ),
      );
    }

    return builder?.call(context, selector) ??
        AppCard(
          width: width,
          height: height,
          contentPadding: const EdgeInsets.all(12),
          actions: [
            FilledButton(
              onPressed: () async {
                final List<UserEntityImpl>? users = await selector();
                if (users != null) {
                  onUsersSelected?.call(users);
                  controller.methods.setUsers(users);
                }
              },
              child: Text(
                'Selecionar ${controller.multiple ? 'usuários' : 'usuário'}',
              ),
            ),
          ],
          child: Center(
            child: controller.builder(
              builder: (context, data) {
                if (data.users.isEmpty) {
                  return const AppIlustration(
                    AppIlustrations.femaleUser,
                    width: 200,
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          '${data.users[0].name[0]}${data.users[0].surname[0]}',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        '${data.users[0].name} ${data.users[0].surname}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
  }
}
