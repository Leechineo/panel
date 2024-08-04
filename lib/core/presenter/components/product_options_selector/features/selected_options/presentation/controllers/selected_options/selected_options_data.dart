import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class SelectedOptionsData {
  final List<ProductEntity> products;
  final List<ProductEntity> selectedProducts;
  final bool loading;
  SelectedOptionsData({
    required this.products,
    required this.selectedProducts,
    required this.loading,
  });

  SelectedOptionsData copyWith({
    List<ProductEntity>? products,
    List<ProductEntity>? selectedProducts,
    bool? loading,
  }) {
    return SelectedOptionsData(
      products: products ?? this.products,
      loading: loading ?? this.loading,
      selectedProducts: selectedProducts ?? this.selectedProducts,
    );
  }
}
