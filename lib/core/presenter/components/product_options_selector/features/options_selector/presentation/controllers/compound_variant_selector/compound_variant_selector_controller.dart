import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/compound_variant_selector/compound_variant_selector_data.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/compound_variant_selector/compound_variant_selector_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class CompoundVariantSelectorController<V> extends AppController<
    CompoundVariantSelectorData, CompoundVariantSelectorMethods> {
  final List<ProductVariantsProperty> properties;
  final List<ProductVariantsOption> options;

  CompoundVariantSelectorController({
    required this.options,
    required this.properties,
  }) {
    methods.updateItems();
  }

  @override
  CompoundVariantSelectorMethods defineMethods() {
    return CompoundVariantSelectorMethods(
      updateItems: () {
        final List<List<ProductVariantsOptionName>> items = [];
        for (int index = 0; index < properties.length; index++) {
          final ProductVariantsProperty property = properties[index];
          final Map<String, dynamic> selectedOptionsRange =
              methods.getObjRange(data.selectedOptions, 0, index);
          final List<ProductVariantsOption> filteredOptions =
              options.where((option) {
            final List<int> notMatch = [];
            for (final selectedOptionEntry in selectedOptionsRange.entries) {
              final selectedOptionKey = selectedOptionEntry.key;
              final List<ProductVariantsOptionName> namesFiltered = option
                  .names!
                  .where((name) => name.id == selectedOptionKey)
                  .toList();
              if (namesFiltered.isNotEmpty &&
                  namesFiltered[0].name !=
                      selectedOptionsRange[selectedOptionKey]) {
                notMatch.add(1);
              }
            }
            return notMatch.isEmpty;
          }).toList();
          final List<ProductVariantsOptionName> names = filteredOptions
              .map((option) => option.names!)
              .expand((name) => name)
              .where((name) => name.id == property.id)
              .toList();
          if (data.selectedOptions[property.id] != '' &&
              names
                  .where(
                      (name) => name.name == data.selectedOptions[property.id])
                  .isEmpty) {
            methods.cleanOptionSelected(property.id);
          }
          items.add(methods.clearRepeatedNames(names));
        }
        updateData(
          data.copyWith(
            items: items,
          ),
        );
      },
      clearRepeatedNames: (names) {
        final uniqueMap = <String, ProductVariantsOptionName>{};
        final resultList = <ProductVariantsOptionName>[];

        for (final item in names) {
          final key = '${item.id}-${item.name}';
          if (!uniqueMap.containsKey(key)) {
            uniqueMap[key] = item;
            resultList.add(item);
          }
        }

        return resultList;
      },
      setSelectedDropdownOption: (propertyId, value) {
        final updatedSelectedOptions =
            Map<String, dynamic>.from(data.selectedOptions);
        updatedSelectedOptions[propertyId] = value;
        updateData(
          data.copyWith(
            selectedOptions: updatedSelectedOptions,
          ),
        );
        methods.updateItems();
        return methods.setSelectedOption();
      },
      getObjRange: (obj, startIndex, endIndex) {
        final keys = obj.keys.toList();
        final subKeys = keys.sublist(startIndex, endIndex);
        final subObj = subKeys.fold<Map<String, dynamic>>({}, (result, key) {
          result[key] = obj[key];
          return result;
        });
        return subObj;
      },
      cleanOptionSelected: (propertyId) {
        final Map<String, dynamic> updatedSelectedOptions =
            Map.from(data.selectedOptions);
        updatedSelectedOptions[propertyId] = '';
        updateData(
          data.copyWith(
            selectedOptions: updatedSelectedOptions,
          ),
        );
      },
      setSelectedOption: () {
        final selectedOptionsQuantity = data.selectedOptions.entries
            .where((e) => e.value.isNotEmpty)
            .length;
        if (selectedOptionsQuantity != properties.length) {
          updateData(
            data.copyWith(
              selectedOption: null,
            ),
          );
        } else {
          final ProductVariantsOption optionSelected =
              options.firstWhere((option) {
            final List<int> namesThatMatches = [];
            for (final selectedOptionsEntry in data.selectedOptions.entries) {
              final propertyId = selectedOptionsEntry.key;
              final List<ProductVariantsOptionName> namesWithThePropertyId =
                  option.names!.where((name) => name.id == propertyId).toList();
              if (namesWithThePropertyId.isNotEmpty &&
                  namesWithThePropertyId.first.name ==
                      data.selectedOptions[propertyId]) {
                namesThatMatches.add(1);
              }
            }
            return namesThatMatches.length == properties.length;
          });
          updateData(
            data.copyWith(
              selectedOption: optionSelected,
            ),
          );
          return optionSelected;
        }
        return null;
      },
    );
  }

  @override
  CompoundVariantSelectorData defineData() {
    return CompoundVariantSelectorData(
      items: properties.map((e) => <ProductVariantsOptionName>[]).toList(),
      selectedOptions: Map.fromEntries(
        properties.map(
          (e) => MapEntry(e.id, ''),
        ),
      ),
      selectedOption: null,
    );
  }
}
