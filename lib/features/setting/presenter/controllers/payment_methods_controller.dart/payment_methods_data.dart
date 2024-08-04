import 'package:flutter/widgets.dart';

import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class ControllerPaymentMethodSetting extends PaymentMethodSettings {
  final TextEditingController discountInputController;
  ControllerPaymentMethodSetting({
    required super.name,
    required super.discount,
    required super.enabled,
    required this.discountInputController,
  });
}

class PaymentMethodsData extends AppControllerData {
  final List<ControllerPaymentMethodSetting> paymentMethods;

  PaymentMethodsData({
    required this.paymentMethods,
  });

  @override
  PaymentMethodsData copyWith({
    List<ControllerPaymentMethodSetting>? paymentMethods,
    bool? loading,
    String? originalPaymentMethods,
  }) {
    return PaymentMethodsData(
      paymentMethods: paymentMethods ?? this.paymentMethods,
    );
  }
}
