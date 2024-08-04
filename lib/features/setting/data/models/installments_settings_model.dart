// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:leechineo_panel/features/setting/data/models/installment_model.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class InstallmentsSettingsModel implements InstallmentsSettings {
  @override
  bool enabled;
  @override
  List<InstallmentModel> installments;

  InstallmentsSettingsModel({
    required this.enabled,
    required this.installments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enabled': enabled,
      'installments': installments.map((x) => x.toMap()).toList(),
    };
  }

  factory InstallmentsSettingsModel.fromMap(Map<String, dynamic> map) {
    return InstallmentsSettingsModel(
      enabled: map['enabled'] as bool,
      installments: List<InstallmentModel>.from(
        (map['installments'] as List<dynamic>).map<Installment>(
          (x) => InstallmentModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InstallmentsSettingsModel.fromJson(String source) =>
      InstallmentsSettingsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InstallmentsSettingsModel(enabled: $enabled, installments: $installments)';
}
