import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';

class BrandColorPicker extends StatelessWidget {
  final void Function(Color color) onColorPicked;
  final void Function() onColorPickerExpansionToggled;
  final Color color;
  final Color brandColor;
  final bool expanded;
  final bool dark;
  const BrandColorPicker({
    required this.color,
    required this.onColorPicked,
    required this.onColorPickerExpansionToggled,
    required this.expanded,
    required this.brandColor,
    this.dark = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultColor =
        dark ? const Color(0xff1E1E1E) : const Color(0xffF5F5F5);
    return AppCard(
      actions: [
        if (brandColor.toString() != defaultColor.toString())
          FilledButton(
            onPressed: color.toString() == defaultColor.toString()
                ? null
                : () {
                    onColorPicked(
                      dark ? const Color(0xff1E1E1E) : const Color(0xffF5F5F5),
                    );
                  },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Cor padrão'),
                AppCard(
                  color:
                      dark ? const Color(0xff1E1E1E) : const Color(0xffF5F5F5),
                  child: const SizedBox(
                    height: 12,
                    width: 12,
                  ),
                ),
              ],
            ),
          ),
        Tooltip(
          message: 'Restaurar cor',
          child: FilledButton(
            onPressed: color.toString() == brandColor.toString()
                ? null
                : () {
                    onColorPicked(brandColor);
                  },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sync_rounded),
                AppCard(
                  color: brandColor,
                  child: const SizedBox(
                    height: 12,
                    width: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      onTap: () {
        onColorPickerExpansionToggled();
      },
      childExpanded: expanded,
      title: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cor de fundo:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              width: 12,
            ),
            AppCard(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: color,
                ),
                width: 70,
                height: 20,
              ),
            )
          ],
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 300,
          child: ColorPicker(
            portraitOnly: true,
            pickerColor: color,
            onColorChanged: (value) {
              onColorPicked(value);
            },
          ),
        ),
      ),
    );
  }
}
