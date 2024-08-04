import 'dart:math';
import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/domain/enums/country_enum.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/core/presenter/utils/display_helper.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/stock/presenter/controllers/stock_editor_page_controller.dart';

class StocksEditorPage extends StatefulWidget {
  final StocksEditorPageController controller;
  const StocksEditorPage({
    required this.controller,
    super.key,
  });

  @override
  State<StocksEditorPage> createState() => _StocksEditorPageState();
}

class _StocksEditorPageState extends State<StocksEditorPage> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 12, 12),
      child: Scaffold(
        body: widget.controller.builder(
          builder: (context, data) {
            if (data.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (data.shippingMethods.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppIlustration(
                      AppIlustrations.containerShip,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Sem métodos de envio',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'Para criar estoques você precisa criar algum méotodo de envio antes.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    FilledButton(
                      onPressed: () {
                        widget.controller.methods.goToShippingMethodsPage();
                      },
                      child: const Text(
                        'Ir para métodos de envio',
                      ),
                    ),
                  ],
                ),
              );
            }
            return AppCard(
              contentPadding: const EdgeInsets.all(12),
              titleText: data.stock.id.isEmpty
                  ? 'Criar novo estoque'
                  : 'Editar estoque',
              actions: [
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Fechar',
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    widget.controller.methods.saveStock();
                  },
                  child: const Text(
                    'Salvar',
                  ),
                )
              ],
              child: Column(
                children: [
                  AppFlex(
                    maxItemsPerRow: 1,
                    maxItemsPerRowMd: 2,
                    spacing: AppFlexSpacing.all(12),
                    children: [
                      DropdownButtonFormField<String>(
                        value: countryEnumToString(data.editStock.country),
                        items: data.countries.map(
                          (country) {
                            return DropdownMenuItem(
                              value: country.value,
                              child: Text(country.label),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            widget.controller.methods.updateStockCountry(
                                countryEnumFromString(value));
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          labelText: 'País',
                        ),
                      ),
                      TextField(
                        controller: widget.controller.form.nameController,
                        onChanged: (value) =>
                            widget.controller.methods.updateStockName(value),
                        decoration: const InputDecoration(
                          labelText: 'Nome do estoque / Localização',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: data.editStock.shippingMethod.isNotEmpty
                            ? data.editStock.shippingMethod
                            : null,
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            widget.controller.methods
                                .updateStockShippingMethod(value);
                          }
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Método de envio',
                        ),
                        items: data.shippingMethods
                            .map(
                              (element) => DropdownMenuItem(
                                value: element.id,
                                child: Text(element.name),
                              ),
                            )
                            .toList(),
                      ),
                      DropdownButtonFormField<String>(
                        value: currencyEnumToString(data.editStock.currency),
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            widget.controller.methods.updateStockCurrency(
                                currencyEnumFromString(value));
                          }
                        },
                        decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            labelText: 'Moeda'),
                        items: data.currencies
                            .map(
                              (currency) => DropdownMenuItem(
                                value: currency.value,
                                child: Text(currency.label),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          eventListener: (context, event, data) {
            if (event.id == 'savingStock') {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return widget.controller.builder(
                    builder: (context, data) {
                      return const Center(
                        child: AppCard(
                          width: 400,
                          height: 150,
                          titleText: 'Salvando estoque...',
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    },
                    eventListener: (context, event, data) {
                      if (event.id == 'savedStock') {
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              );
            }
            if (event.id == 'savedStock') {
              Navigator.maybePop(context);
            }
          },
          allowAlertDialog: true,
        ),
      ),
    );
  }
}

double getDropdownWidth(
    DisplayHelper displayHelper, BoxConstraints constraints) {
  if (displayHelper.moreThanSm) {
    return max<double>(10, constraints.maxWidth * 0.5 - 24);
  } else {
    return max<double>(10, max<double>(10, constraints.maxWidth - 48));
  }
}
