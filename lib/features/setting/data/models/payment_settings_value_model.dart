// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:leechineo_panel/features/setting/data/models/installments_settings_model.dart';
import 'package:leechineo_panel/features/setting/data/models/payment_method_settings_model.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class PaymentSettingsValueModel implements PaymentSettingsValue {
  @override
  InstallmentsSettingsModel installments;
  @override
  List<PaymentMethodSettingsModel> paymentMethods;

  PaymentSettingsValueModel({
    required this.installments,
    required this.paymentMethods,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paymentMethods': paymentMethods.map((x) => x.toMap()).toList(),
      'installments': installments.toMap(),
    };
  }

  factory PaymentSettingsValueModel.fromMap(Map<String, dynamic> map) {
    return PaymentSettingsValueModel(
      paymentMethods: List<PaymentMethodSettingsModel>.from(
        (map['paymentMethods'] as List<dynamic>).map<PaymentMethodSettings>(
          (x) => PaymentMethodSettingsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      installments: InstallmentsSettingsModel.fromMap(
          map['installments'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentSettingsValueModel.fromJson(String source) =>
      PaymentSettingsValueModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PaymentSettingsValueModel(installments: $installments, paymentMethods: $paymentMethods)';
}
