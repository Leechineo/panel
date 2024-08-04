import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class ControllerInstallmentSetting extends Installment {
  final TextEditingController priceTextController;
  final TextEditingController interestTextController;
  ControllerInstallmentSetting({
    required this.interestTextController,
    required this.priceTextController,
    required super.installmentValue,
    required super.minPriceValue,
    required super.interest,
  });
}

class ControllerInstallmentsSettings extends InstallmentsSettings {
  @override
  // ignore: overridden_fields
  final List<ControllerInstallmentSetting> installments;

  ControllerInstallmentsSettings({
    required super.enabled,
    required this.installments,
  }) : super(installments: installments);
}

class InstallmentSettingsData implements AppControllerData {
  final ControllerInstallmentsSettings installmentsSettings;

  InstallmentSettingsData({
    required this.installmentsSettings,
  });

  @override
  InstallmentSettingsData copyWith({
    ControllerInstallmentsSettings? installmentsSettings,
  }) {
    return InstallmentSettingsData(
      installmentsSettings: installmentsSettings ?? this.installmentsSettings,
    );
  }
}
