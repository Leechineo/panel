import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class CompoundVariantSelectorData {
  final List<List<ProductVariantsOptionName>> items;
  final Map<String, dynamic> selectedOptions;
  final ProductVariantsOption? selectedOption;
  CompoundVariantSelectorData({
    required this.items,
    required this.selectedOptions,
    required this.selectedOption,
  });

  CompoundVariantSelectorData copyWith({
    List<List<ProductVariantsOptionName>>? items,
    Map<String, dynamic>? selectedOptions,
    ProductVariantsOption? selectedOption,
  }) {
    return CompoundVariantSelectorData(
      items: items ?? this.items,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }
}
