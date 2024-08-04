import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class PaymentMethodsMethods {
  final Function(
    PaymentMethodName paymentMethodName,
    String value,
  ) updateDiscount;
  final Function(
    PaymentMethodName paymentMethodName, {
    bool? enabled,
  }) updateEnabledStatus;
  final Function(
    List<PaymentMethodSettings> paymentMethodSettings,
  ) definePaymentMethodsSettings;

  PaymentMethodsMethods({
    required this.updateDiscount,
    required this.updateEnabledStatus,
    required this.definePaymentMethodsSettings,
  });
}
