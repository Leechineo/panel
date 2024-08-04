// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:leechineo_panel/features/setting/data/models/payment_settings_value_model.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class PaymentSettingsModel implements PaymentSettingsEntity {
  @override
  DateTime createdAt;
  @override
  String id;
  @override
  String name;
  @override
  PaymentSettingsValueModel value;

  PaymentSettingsModel({
    required this.createdAt,
    required this.id,
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt.toString(),
      'id': id,
      'name': name,
      'value': value.toMap(),
    };
  }

  factory PaymentSettingsModel.fromMap(Map<String, dynamic> map) {
    return PaymentSettingsModel(
      createdAt:
          DateTime.tryParse(map['createdAt'] as String) ?? DateTime.now(),
      id: map['id'] as String,
      name: map['name'] as String,
      value: PaymentSettingsValueModel.fromMap(
          map['value'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentSettingsModel.fromJson(String source) =>
      PaymentSettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentSettingsModel(createdAt: $createdAt, id: $id, name: $name, value: $value)';
  }
}
