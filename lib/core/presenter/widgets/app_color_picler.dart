import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';

class AppColorPicker extends StatelessWidget {
  final void Function(Color color)? onColorPicked;
  final Color? value;
  const AppColorPicker({
    this.onColorPicked,
    this.value,
    super.key,
  });

  static Future<Color?> dialog(BuildContext context, {Color? color}) {
    Color pickerColor = Colors.white;
    return showDialog<Color>(
      context: context,
      builder: (context) {
        return Center(
          child: AppCard(
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop<Color>(context, pickerColor);
                },
                child: const Text('Concluir'),
              )
            ],
            width: 300,
            height: 464,
            child: AppColorPicker(
              onColorPicked: (selectedColor) {
                pickerColor = selectedColor;
              },
              value: color,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColorPicker(
      portraitOnly: true,
      pickerColor: value ?? Colors.white,
      onColorChanged: (value) {
        onColorPicked?.call(value);
      },
    );
  }
}
