import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

abstract class SavePaymentSettingsUseCase {
  Future<PaymentSettingsEntity> call(PaymentSettingsEntity paymentSettings);
}
