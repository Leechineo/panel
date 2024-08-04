import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class InstallmentSettingsMethods {
  final void Function() addInstallment;
  final void Function() removeLastInstallment;
  final void Function(
    int installmentValue, {
    double? interest,
    double? minPriceValue,
  }) updateInstallment;
  final void Function(int installmentValue, String interest) updateInterest;
  final void Function(
    int installmentValue,
    String minPriceValue,
  ) updateMinPriceValue;
  final void Function({bool? enabled}) updateEnabledStatus;
  final void Function(
    InstallmentsSettings installmetSettings,
  ) defineInstallmentSettings;

  InstallmentSettingsMethods({
    required this.addInstallment,
    required this.removeLastInstallment,
    required this.updateInstallment,
    required this.updateInterest,
    required this.updateMinPriceValue,
    required this.updateEnabledStatus,
    required this.defineInstallmentSettings,
  });
}
