import 'package:leechineo_panel/core/domain/enums/country_enum.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';

abstract class StockEntity {
  final String id;
  final String name;
  final CountryEnum country;
  final CurrencyEnum currency;
  final String shippingMethod;
  final DateTime createdAt;

  StockEntity({
    required this.id,
    required this.name,
    required this.country,
    required this.currency,
    required this.shippingMethod,
    required this.createdAt,
  });
}
