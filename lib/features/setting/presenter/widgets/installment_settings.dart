import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/installment_settings_controller/Installment_settings_controller.dart';

class InstallmentSettingsWidget extends StatelessWidget {
  final InstallmentSettingsController controller;
  final bool loading;
  final void Function(InstallmentsSettings installmentsSettings)
      onInstallmentsUpdated;
  const InstallmentSettingsWidget({
    required this.controller,
    required this.loading,
    required this.onInstallmentsUpdated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(
      builder: (context, data) {
        return AppCard(
          titleText: 'Parcelas configuradas',
          actions: [
            FilledButton(
              onPressed: data.installmentsSettings.installments.isEmpty
                  ? null
                  : controller.methods.removeLastInstallment,
              child: const Text('Remover parcelamento'),
            ),
            FilledButton(
              onPressed: controller.methods.addInstallment,
              child: const Text('Adicionar'),
            ),
          ],
          child: Builder(
            builder: (context) {
              if (loading) {
                return const Center(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(86),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              if (data.installmentsSettings.installments.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Column(
                      children: [
                        const AppIlustration(
                          AppIlustrations.creditCard,
                          width: 150,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Sem Parcelamento Configurado',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CheckboxListTile(
                      value: data.installmentsSettings.enabled,
                      onChanged: (value) =>
                          controller.methods.updateEnabledStatus(
                        enabled: value,
                      ),
                      title: const Text('Parcelamento ativado'),
                    ),
                  ),
                  Form(
                    key: controller.formKey,
                    child: AppFlex(
                      wrap: true,
                      maxItemsPerRow: 1,
                      maxItemsPerRowMd: 2,
                      children: data.installmentsSettings.installments
                          .map(
                            (installment) => AppCard(
                              titleText: '${installment.installmentValue}x',
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: AppFlex(
                                  maxItemsPerRow: 1,
                                  maxItemsPerRowMd: 2,
                                  children: [
                                    TextField(
                                      controller:
                                          installment.priceTextController,
                                      onChanged: (value) => controller.methods
                                          .updateMinPriceValue(
                                        installment.installmentValue,
                                        value,
                                      ),
                                      onTapOutside: (event) {
                                        installment.priceTextController.text =
                                            installment.minPriceValue
                                                .toStringAsFixed(2)
                                                .replaceAll('.', ',');
                                      },
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: 'Preço mínimo',
                                        enabled:
                                            installment.installmentValue != 1,
                                        isDense: true,
                                        prefix: const Text('R\$'),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9,\.]'),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: TextField(
                                        controller:
                                            installment.interestTextController,
                                        onChanged: (value) =>
                                            controller.methods.updateInterest(
                                          installment.installmentValue,
                                          value,
                                        ),
                                        onTapOutside: (event) {
                                          installment
                                                  .interestTextController.text =
                                              installment.interest
                                                  .toStringAsFixed(2)
                                                  .replaceAll('.', ',');
                                        },
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: 'Juros',
                                          enabled:
                                              installment.installmentValue != 1,
                                          isDense: true,
                                          suffix: const Text('%'),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9,\.]'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      eventListener: (context, event, data) {
        if (event.id == 'updated_installments') {
          onInstallmentsUpdated(data.installmentsSettings);
        }
      },
    );
  }
}
