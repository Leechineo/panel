import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_arrive_time_dto.dart';
import 'package:leechineo_panel/features/shipping_method/domain/dtos/shipping_method_price_dto.dart';

abstract class ShippingMethodMappingDTO {
  final String? id;
  final String? zipcode;
  final String regionRadius;
  final ShippingMethodArriveTimeDTO arriveTime;
  final ShippingMethodPriceDTO price;

  ShippingMethodMappingDTO({
    this.id,
    this.zipcode,
    required this.regionRadius,
    required this.arriveTime,
    required this.price,
  });
}
