import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class OptionsSelectorData {
  final bool loading;
  final List<ProductEntity> products;
  final List<ProductEntity> selectedProducts;
  final PaginationArgs pagination;

  OptionsSelectorData({
    required this.loading,
    required this.products,
    required this.selectedProducts,
    required this.pagination,
  });

  OptionsSelectorData copyWith({
    bool? loading,
    List<ProductEntity>? products,
    List<ProductEntity>? selectedProducts,
    PaginationArgs? pagination,
  }) {
    return OptionsSelectorData(
      loading: loading ?? this.loading,
      products: products ?? this.products,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      pagination: pagination ?? this.pagination,
    );
  }
}
