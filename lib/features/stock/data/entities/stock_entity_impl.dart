import 'package:leechineo_panel/core/domain/enums/country_enum.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/features/stock/domain/entities/stock_entity.dart';

class StockEntityImpl extends StockEntity {
  StockEntityImpl({
    required super.id,
    required super.name,
    required super.country,
    required super.currency,
    required super.shippingMethod,
    required super.createdAt,
  });

  StockEntityImpl copyWith({
    String? id,
    String? name,
    CountryEnum? country,
    CurrencyEnum? currency,
    String? shippingMethod,
    DateTime? createdAt,
  }) {
    return StockEntityImpl(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      currency: currency ?? this.currency,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
