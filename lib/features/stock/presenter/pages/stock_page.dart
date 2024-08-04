import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/stock/presenter/controllers/stock_page_controller.dart';

class StocksPage extends StatelessWidget {
  final StocksPageController controller;
  const StocksPage({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 12, 12),
      child: controller.builder(
        builder: (context, data) {
          if (data.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (data.stocks.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppIlustration(
                  AppIlustrations.containerShip,
                  width: 200,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Sem estoques',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
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
                onPressed: () {
                  controller.methods.goToEditorPage('null');
                },
                child: const Text('Criar estoque'),
              ),
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
                    'País',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Método de envio',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Moeda',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(),
                ),
              ],
              rows: data.stocks
                  .map(
                    (stock) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            stock.name,
                          ),
                        ),
                        DataCell(
                          Text(
                            controller.methods.getCountryNameByCode(
                              stock.country,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            controller.methods.getShippingMethodNameById(
                              stock.shippingMethod,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            controller.methods.getCurrencyNameByCode(
                              stock.currency,
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.methods.goToEditorPage(stock.id);
                                },
                                style: ButtonStyle(
                                  iconColor: MaterialStatePropertyAll(
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.edit_rounded,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  iconColor: MaterialStatePropertyAll(
                                    Colors.red[400],
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.delete_rounded,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
        allowAlertDialog: true,
      ),
    );
  }
}
