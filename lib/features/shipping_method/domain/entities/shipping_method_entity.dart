// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/core/domain/enums/region_radius_enum.dart';

class ShippingMethodPrice {
  final CurrencyEnum currency;
  final double value;

  ShippingMethodPrice({
    required this.currency,
    required this.value,
  });

  @override
  String toString() =>
      'ShippingMethodPrice(currency: $currency, value: $value)';
}

class ShippingMethodArriveTime {
  final int min;
  final int max;

  ShippingMethodArriveTime({
    required this.min,
    required this.max,
  });
}

class ShippingMethodMapping {
  final String? id;
  final String? zipcode;
  final RegionRadiusEnum? regionRadius;
  final ShippingMethodArriveTime arriveTime;
  final ShippingMethodPrice price;

  ShippingMethodMapping({
    this.id,
    this.regionRadius,
    this.zipcode,
    required this.price,
    required this.arriveTime,
  });

  @override
  String toString() {
    return 'ShippingMethodMapping(id: $id, zipcode: $zipcode, regionRadius: $regionRadius, arriveTime: $arriveTime, price: $price)';
  }
}

class ShippingMethodProduct {
  final int id;
  final List<ShippingMethodMapping> mappings;

  ShippingMethodProduct({
    required this.id,
    required this.mappings,
  });
}

abstract class ShippingMethodEntity {
  final String id;
  final String name;
  final ShippingMethodMapping defaultMapping;
  final List<ShippingMethodMapping> mappings;
  final List<ShippingMethodProduct> products;
  final DateTime createdAt;

  ShippingMethodEntity({
    required this.id,
    required this.name,
    required this.defaultMapping,
    required this.mappings,
    required this.products,
    required this.createdAt,
  });
}
