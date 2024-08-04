// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';

enum OrderPaymentStatus {
  approved,
  cancelled,
  refunded,
  inAnalisis,
  refused,
  separated,
  invoiced,
  onTheWay,
}

enum OrderPaymentMethod {
  bankSlip,
  creditCard,
  pix,
}

abstract class OrderPayment {
  final OrderPaymentStatus status;
  final String price;
  final int installments;
  final OrderPaymentMethod method;

  OrderPayment({
    required this.status,
    required this.price,
    required this.installments,
    required this.method,
  });
}

abstract class OrderItemOption {
  final String id;
  final List<String> variant;
  final double price;

  OrderItemOption({
    required this.id,
    required this.variant,
    required this.price,
  });

  @override
  String toString() =>
      'OrderItemOption(id: $id, variant: $variant, price: $price)';
}

abstract class OrderItem {
  final int id;
  final String name;
  final List<String> images;
  final String stockId;
  final List<ProductSpecification> specifications;
  final OrderItemOption option;
  final int quantity;
  final CurrencyEnum currency;

  OrderItem({
    required this.id,
    required this.name,
    required this.images,
    required this.stockId,
    required this.specifications,
    required this.option,
    required this.quantity,
    required this.currency,
  });

  @override
  String toString() {
    return 'OrderItem(id: $id, name: $name, images: $images, stockId: $stockId, specifications: $specifications, option: $option, quantity: $quantity, currency: $currency)';
  }
}

abstract class OrderEntity {
  final String id;
  final String user;
  final String transactionId;
  final AddressEntity address;
  final List<OrderItem> items;
  final OrderPayment payment;
  final ShippingMethodEntity shippingMethod;
  final String invoice;
  final String tracking;
  final DateTime createdAt;

  OrderEntity({
    required this.id,
    required this.user,
    required this.transactionId,
    required this.address,
    required this.items,
    required this.payment,
    required this.shippingMethod,
    required this.invoice,
    required this.tracking,
    required this.createdAt,
  });
}
