import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

abstract class GetPaymentSettingsUseCase {
  Future<PaymentSettingsEntity> call({bool? refresh});
}
