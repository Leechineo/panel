import 'package:intl/intl.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';

class CurrencyModel {
  final double value;
  final CurrencyEnum code;

  CurrencyModel({
    required this.value,
    required this.code,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      value: json['value'],
      code: json['code'],
    );
  }

  CurrencyModel copyWith({
    double? value,
    CurrencyEnum? code,
  }) {
    return CurrencyModel(
      value: value ?? this.value,
      code: code ?? this.code,
    );
  }

  factory CurrencyModel.newWith({
    double? value,
    CurrencyEnum? code,
  }) {
    return CurrencyModel(
      value: value ?? 0,
      code: code ?? CurrencyEnum.brl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'code': code,
    };
  }

  String format() {
    late String formattedPrice;
    final NumberFormat brazillianFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final NumberFormat usaFormat =
        NumberFormat.currency(locale: 'en_US', symbol: '\$');
    if (code == CurrencyEnum.brl) {
      formattedPrice = brazillianFormat.format(value);
    } else {
      formattedPrice = usaFormat.format(value);
    }
    return formattedPrice;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
