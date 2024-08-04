import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/installment_settings_controller/installment_settings_data.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/installment_settings_controller/installment_settings_methods.dart';

class InstallmentSettingsController
    extends AppController<InstallmentSettingsData, InstallmentSettingsMethods> {
  final GlobalKey formKey = GlobalKey<FormState>();

  InstallmentSettingsController();

  @override
  InstallmentSettingsData defineData() {
    return InstallmentSettingsData(
      installmentsSettings: ControllerInstallmentsSettings(
        enabled: false,
        installments: [],
      ),
    );
  }

  @override
  InstallmentSettingsMethods defineMethods() {
    return InstallmentSettingsMethods(
      defineInstallmentSettings: (installmetSettings) {
        updateData(
          data.copyWith(
            installmentsSettings: ControllerInstallmentsSettings(
              enabled: installmetSettings.enabled,
              installments: installmetSettings.installments
                  .map(
                    (e) => ControllerInstallmentSetting(
                      interestTextController: TextEditingController(
                        text:
                            e.interest.toStringAsFixed(2).replaceAll('.', ','),
                      ),
                      priceTextController: TextEditingController(
                        text: e.minPriceValue
                            .toStringAsFixed(2)
                            .replaceAll('.', ','),
                      ),
                      installmentValue: e.installmentValue,
                      minPriceValue: e.minPriceValue,
                      interest: e.interest,
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
      addInstallment: () {
        final installments = data.installmentsSettings.installments;
        late final double minPriceValue;
        late final double interest;

        if (data.installmentsSettings.installments.isEmpty) {
          minPriceValue = 0;
          interest = 0;
        } else {
          minPriceValue =
              data.installmentsSettings.installments.last.minPriceValue;
          interest = data.installmentsSettings.installments.last.interest;
        }

        installments.add(
          ControllerInstallmentSetting(
            installmentValue: installments.length + 1,
            minPriceValue: minPriceValue,
            interest: interest,
            interestTextController: TextEditingController(
              text: interest.toStringAsFixed(2).replaceAll('.', ','),
            ),
            priceTextController: TextEditingController(
              text: minPriceValue.toStringAsFixed(2).replaceAll('.', ','),
            ),
          ),
        );
        updateData(
          data.copyWith(
            installmentsSettings: ControllerInstallmentsSettings(
              enabled: data.installmentsSettings.enabled,
              installments: installments,
            ),
          ),
        );
        dispatchEvent(
          AppControllerEvent(
            id: 'updated_installments',
            data: data,
          ),
        );
      },
      removeLastInstallment: () {
        final installments = data.installmentsSettings.installments;
        if (data.installmentsSettings.installments.isNotEmpty) {
          installments.removeLast();
        }
        updateData(
          data.copyWith(
            installmentsSettings: ControllerInstallmentsSettings(
              enabled: data.installmentsSettings.enabled,
              installments: installments,
            ),
          ),
        );
        dispatchEvent(
          AppControllerEvent(
            id: 'updated_installments',
            data: data,
          ),
        );
      },
      updateInstallment: (installmentValue, {interest, minPriceValue}) {
        final installmentsFiltered =
            data.installmentsSettings.installments.where(
          (element) => element.installmentValue == installmentValue,
        );
        final installmentExists = installmentsFiltered.isNotEmpty;

        if (installmentExists) {
          final installment = installmentsFiltered.first;
          final updatedInstallment = ControllerInstallmentSetting(
            interestTextController: installment.interestTextController,
            priceTextController: installment.priceTextController,
            installmentValue: installmentValue,
            minPriceValue: minPriceValue ?? installment.minPriceValue,
            interest: interest ?? installment.interest,
          );
          final installmentIndex =
              data.installmentsSettings.installments.indexOf(installment);
          final installments = data.installmentsSettings.installments;
          installments[installmentIndex] = updatedInstallment;
          updateData(
            data.copyWith(
              installmentsSettings: ControllerInstallmentsSettings(
                enabled: data.installmentsSettings.enabled,
                installments: installments,
              ),
            ),
          );
        }
        dispatchEvent(
          AppControllerEvent(
            id: 'updated_installments',
            data: data,
          ),
        );
      },
      updateInterest: (installmentValue, interest) {
        late final double? interestParsed;
        if (interest.isEmpty) {
          interestParsed = 0;
        } else {
          interestParsed = double.tryParse(
            interest.replaceAll(',', '.'),
          );
        }
        methods.updateInstallment(
          installmentValue,
          interest: interestParsed,
        );
        dispatchEvent(
          AppControllerEvent(
            id: 'updated_installments',
            data: data,
          ),
        );
      },
      updateMinPriceValue: (installmentValue, minPriceValue) {
        late final double? minPriceValueParsed;
        if (minPriceValue.isEmpty) {
          minPriceValueParsed = 0;
        } else {
          minPriceValueParsed = double.tryParse(
            minPriceValue.replaceAll(',', '.'),
          );
        }
        methods.updateInstallment(
          installmentValue,
          minPriceValue: minPriceValueParsed,
        );
        dispatchEvent(
          AppControllerEvent(
            id: 'updated_installments',
            data: data,
          ),
        );
      },
      updateEnabledStatus: ({enabled}) {
        updateData(
          data.copyWith(
            installmentsSettings: ControllerInstallmentsSettings(
              enabled: enabled ?? !data.installmentsSettings.enabled,
              installments: data.installmentsSettings.installments,
            ),
          ),
        );
        dispatchEvent(
          AppControllerEvent(
            id: 'updated_installments',
            data: data,
          ),
        );
      },
    );
  }
}
