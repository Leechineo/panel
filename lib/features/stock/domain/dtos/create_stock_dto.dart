class CreateStockDTO {
  final String name;
  final String country;
  final String currency;
  final String shippingMethod;

  CreateStockDTO({
    required this.name,
    required this.country,
    required this.currency,
    required this.shippingMethod,
  });
}
