import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/features/order/domain/entities/order_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';
import 'package:leechineo_panel/features/product/domain/enums/product_variants_type_enum.dart';

class OrderItemOptionImpl extends OrderItemOption {
  OrderItemOptionImpl({
    required super.id,
    required super.variant,
    required super.price,
  });
  OrderItemOptionImpl copyWith({
    String? id,
    List<String>? variant,
    double? price,
  }) {
    return OrderItemOptionImpl(
      id: id ?? this.id,
      variant: variant ?? this.variant,
      price: price ?? this.price,
    );
  }
}

class OrderItemImpl extends OrderItem {
  @override
  // ignore: overridden_fields
  final OrderItemOptionImpl option;
  OrderItemImpl({
    required super.id,
    required super.name,
    required super.images,
    required super.stockId,
    required super.specifications,
    required this.option,
    required super.quantity,
    required super.currency,
  }) : super(option: option);

  OrderItemImpl copyWith({
    int? id,
    String? name,
    List<String>? images,
    String? stockId,
    List<ProductSpecification>? specifications,
    OrderItemOptionImpl? option,
    int? quantity,
    CurrencyEnum? currency,
  }) {
    return OrderItemImpl(
      id: id ?? this.id,
      name: name ?? this.name,
      images: images ?? this.images,
      stockId: stockId ?? this.stockId,
      specifications: specifications ?? this.specifications,
      option: option ?? this.option,
      quantity: quantity ?? this.quantity,
      currency: currency ?? this.currency,
    );
  }

  factory OrderItemImpl.fromProductAndOption({
    required ProductEntity product,
    required ProductVariantsOption option,
    required int quantity,
    required ProductStock stock,
    required CurrencyEnum currency,
  }) {
    List<String> generateVariants() {
      List<String> variant = [];
      if (stock.variants.type == ProductVariantsTypeEnum.simple) {
        variant = [option.name!];
      }
      if (stock.variants.type == ProductVariantsTypeEnum.compound) {
        variant = option.names!.map((e) => e.name).toList();
      }
      return variant;
    }

    return OrderItemImpl(
      id: product.id,
      name: product.name,
      images: option.images ?? product.images,
      stockId: stock.stock,
      specifications: product.specifications,
      quantity: quantity,
      currency: currency,
      option: OrderItemOptionImpl(
        id: option.id,
        variant: generateVariants(),
        price: option.price,
      ),
    );
  }
}
