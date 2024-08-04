// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class PaymentMethodSettingsModel implements PaymentMethodSettings {
  @override
  double discount;
  @override
  bool enabled;
  @override
  PaymentMethodName name;

  PaymentMethodSettingsModel({
    required this.discount,
    required this.enabled,
    required this.name,
  });

  @override
  String nameToString() {
    switch (name) {
      case PaymentMethodName.pix:
        return 'pix';
      case PaymentMethodName.slip:
        return 'slip';
      case PaymentMethodName.creditCard:
        return 'credit_card';
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'discount': discount,
      'enabled': enabled,
      'name': nameToString(),
    };
  }

  factory PaymentMethodSettingsModel.fromMap(Map<String, dynamic> map) {
    PaymentMethodName nameFromString(String name) {
      switch (name) {
        case 'pix':
          return PaymentMethodName.pix;
        case 'slip':
          return PaymentMethodName.slip;
        default:
          return PaymentMethodName.creditCard;
      }
    }

    return PaymentMethodSettingsModel(
      discount: map['discount'] is int
          ? (map['discount'] as int).toDouble()
          : map['discount'],
      enabled: map['enabled'] as bool,
      name: nameFromString(map['name']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodSettingsModel.fromJson(String source) =>
      PaymentMethodSettingsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PaymentMethodSettingsModel(discount: $discount, enabled: $enabled, name: $name)';
}
