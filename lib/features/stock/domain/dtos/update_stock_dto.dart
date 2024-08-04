class UpdateStockDTO {
  final String id;
  final String? name;
  final String? country;
  final String? currency;
  final String? shippingMethod;

  UpdateStockDTO({
    required this.id,
    this.name,
    this.country,
    this.currency,
    this.shippingMethod,
  });
}
