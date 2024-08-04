import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/user/presenter/controller/user_page_controller/user_page_controller.dart';

class UserPage extends StatelessWidget {
  final UserPageController userController;
  const UserPage({
    required this.userController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 12, 12),
      child: Scaffold(
        body: userController.builder(
          builder: (context, data) {
            if (data.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (data.users.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppIlustration(
                      AppIlustrations.femaleUser,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Sem usuários',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              );
            }
            return AppCard(
              scrollable: false,
              flexible: true,
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
                      leading: const Icon(Icons.search_rounded),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16),
                      ),
                      shadowColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                    ),
                  );
                },
              ),
              actions: [
                FilledButton(
                  onPressed: () => userController.methods.goToEditorPage(),
                  child: const Text('Adicionar usuário'),
                )
              ],
              child: DataTable2(
                columns: [
                  DataColumn(
                    label: Text(
                      'Nome',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Email',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'CPF',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  DataColumn(label: Container())
                ],
                rows: data.users
                    .map(
                      (user) => DataRow(
                        cells: [
                          DataCell(
                            Row(
                              children: [
                                Icon(
                                  user.admin
                                      ? Icons.shield
                                      : Icons.person_3_rounded,
                                  color: data.currentUser.email == user.email
                                      ? Colors.green
                                      : Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text('${user.name} ${user.surname}'),
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Text(user.email),
                          ),
                          DataCell(
                            Text(user.cpf),
                          ),
                          DataCell(
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => userController.methods
                                        .goToEditorPage(user: user),
                                    style: ButtonStyle(
                                      iconColor: MaterialStatePropertyAll(
                                        Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.edit,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
