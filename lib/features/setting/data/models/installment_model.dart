// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class InstallmentModel implements Installment {
  @override
  int installmentValue;
  @override
  double interest;
  @override
  double minPriceValue;

  InstallmentModel({
    required this.installmentValue,
    required this.interest,
    required this.minPriceValue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'installmentValue': installmentValue,
      'interest': interest,
      'minPriceValue': minPriceValue,
    };
  }

  factory InstallmentModel.fromMap(Map<String, dynamic> map) {
    return InstallmentModel(
      installmentValue: map['installmentValue'] as int,
      interest: map['interest'] is int
          ? (map['interest'] as int).toDouble()
          : map['interest'],
      minPriceValue: map['minPriceValue'] is int
          ? (map['minPriceValue'] as int).toDouble()
          : map['minPriceValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InstallmentModel.fromJson(String source) =>
      InstallmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InstallmentModel(installmentValue: $installmentValue, interest: $interest, minPriceValue: $minPriceValue)';
}
