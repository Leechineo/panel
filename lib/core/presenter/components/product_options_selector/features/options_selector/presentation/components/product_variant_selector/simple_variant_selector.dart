import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class SimpleVariantSelector extends StatelessWidget {
  final ProductVariants variants;
  final void Function(ProductVariantsOption option) onSelected;
  const SimpleVariantSelector({
    required this.variants,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField(
          items: variants.options!.map((option) {
            return DropdownMenuItem(
              value: option.id,
              child: Text(option.name!),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              final variantSelected = variants.options!
                  .firstWhere((element) => element.id == value);
              onSelected(variantSelected);
            }
          },
          decoration: const InputDecoration(
            labelText: 'Selecionar variante',
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
