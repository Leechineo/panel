import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/features/options_selector/presentation/controllers/compound_variant_selector/compound_variant_selector_controller.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class CompoundVariantSelector extends StatelessWidget {
  final CompoundVariantSelectorController controller;
  final void Function(ProductVariantsOption option) onOptionSelected;
  const CompoundVariantSelector({
    required this.controller,
    required this.onOptionSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(builder: (context, data) {
      return SizedBox(
        height: 215,
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: controller.properties.asMap().entries.map<Widget>(
                (entry) {
                  final int index = entry.key;
                  final ProductVariantsProperty property = entry.value;
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        items: data.items[index]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.name,
                                child: Text(
                                  e.name,
                                ),
                              ),
                            )
                            .toList(),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          labelText: property.name,
                        ),
                        value: data.selectedOptions[property.id].isEmpty
                            ? null
                            : data.selectedOptions[property.id],
                        onChanged: (value) {
                          if (value != null) {
                            final selectedOption =
                                controller.methods.setSelectedDropdownOption(
                              property.id,
                              value,
                            );
                            if (selectedOption != null) {
                              onOptionSelected(selectedOption);
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  );
                },
              ).toList()),
        ),
      );
    });
  }
}
