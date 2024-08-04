import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class PaymentSettingsPageData extends AppControllerData {
  final bool loading;
  final bool saving;
  final PaymentSettingsEntity currentSettings;
  final String orignalPaymentSettings;

  PaymentSettingsPageData({
    required this.loading,
    required this.saving,
    required this.currentSettings,
    required this.orignalPaymentSettings,
  });

  @override
  PaymentSettingsPageData copyWith({
    bool? loading,
    bool? saving,
    PaymentSettingsEntity? currentSettings,
    String? orignalPaymentSettings,
  }) {
    return PaymentSettingsPageData(
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      currentSettings: currentSettings ?? this.currentSettings,
      orignalPaymentSettings:
          orignalPaymentSettings ?? this.orignalPaymentSettings,
    );
  }
}
