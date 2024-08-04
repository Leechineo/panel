abstract class ShippingMethodPriceDTO {
  final String currency;
  final double value;

  ShippingMethodPriceDTO({
    required this.currency,
    required this.value,
  });
}
