import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

abstract class SettingsDatasource {
  Future<PaymentSettingsEntity> getPaymentSettings({required bool refresh});
  Future<PaymentSettingsEntity> savePaymentSettings(
    PaymentSettingsEntity paymentSettings,
  );
}
