import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class CompoundVariantSelectorMethods {
  final void Function() updateItems;
  final List<ProductVariantsOptionName> Function(
      List<ProductVariantsOptionName> names) clearRepeatedNames;
  final ProductVariantsOption? Function(String propertyId, String value)
      setSelectedDropdownOption;
  final Map<String, dynamic> Function(
      Map<String, dynamic> obj, int startIndex, int endIndex) getObjRange;
  final void Function(String propertyId) cleanOptionSelected;
  final ProductVariantsOption? Function() setSelectedOption;
  CompoundVariantSelectorMethods({
    required this.updateItems,
    required this.clearRepeatedNames,
    required this.setSelectedDropdownOption,
    required this.getObjRange,
    required this.cleanOptionSelected,
    required this.setSelectedOption,
  });
}
