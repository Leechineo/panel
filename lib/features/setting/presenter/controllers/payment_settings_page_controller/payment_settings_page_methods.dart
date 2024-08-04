import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class PaymentSettingsPageMethods {
  final Future<void> Function() savePaymentSettings;
  final bool Function() isSaveButtonEnabled;
  final Future<void> Function() loadPaymentSettings;
  final void Function({
    InstallmentsSettings? installmentsSettings,
    List<PaymentMethodSettings>? paymentMethodSettings,
  }) onUpdated;

  PaymentSettingsPageMethods({
    required this.savePaymentSettings,
    required this.isSaveButtonEnabled,
    required this.loadPaymentSettings,
    required this.onUpdated,
  });
}
