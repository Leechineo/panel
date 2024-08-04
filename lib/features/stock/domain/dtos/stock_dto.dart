// ignore_for_file: public_member_api_docs, sort_constructors_first
class StockDTO {
  final String id;
  final String name;
  final String country;
  final String currency;
  final String shippingMethod;
  final String createdAt;

  StockDTO({
    required this.id,
    required this.name,
    required this.country,
    required this.currency,
    required this.shippingMethod,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'StockDTO(id: $id, name: $name, country: $country, currency: $currency, shippingMethod: $shippingMethod, createdAt: $createdAt)';
  }
}
