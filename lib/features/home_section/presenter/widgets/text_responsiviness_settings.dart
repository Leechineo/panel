import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/data/utils/color_utils.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_color_picler.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/text_element.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/responsiviness_widget.dart';
import 'package:leechineo_panel/features/home_section/utils/text_element_style_translator.dart';

class TextResponsivinessSettings extends StatefulWidget {
  final TextElement textElement;
  final void Function() onTextUpdated;
  const TextResponsivinessSettings({
    required this.textElement,
    required this.onTextUpdated,
    super.key,
  });

  @override
  State<TextResponsivinessSettings> createState() =>
      _TextResponsivinessSettingsState();
}

class _TextResponsivinessSettingsState
    extends State<TextResponsivinessSettings> {
  @override
  Widget build(BuildContext context) {
    Widget settingsWidget(ResponsivinessTextOptions textOptions) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  AppCard(
                    titleText: 'Tamanho da fonte',
                    child: Slider(
                      min: 4,
                      max: 40,
                      divisions: 9,
                      value: textOptions.style.fontSize,
                      label: textOptions.style.fontSize.toString(),
                      onChanged: (value) {
                        setState(() {
                          textOptions.style.fontSize = value;
                          widget.onTextUpdated();
                        });
                      },
                    ),
                  ),
                  AppCard(
                    titleText: 'Peso da fonte',
                    child: Slider(
                      value: textOptions.style.fontWeight.toDouble(),
                      min: 100,
                      max: 900,
                      divisions: 8,
                      label: textOptions.style.fontWeight.toString(),
                      onChanged: (value) {
                        setState(() {
                          textOptions.style.fontWeight = value.toInt();
                          widget.onTextUpdated();
                        });
                      },
                    ),
                  ),
                  AppCard(
                    titleText: 'Estilo do texto',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: SegmentedButton<TextElementFontStyle>(
                          onSelectionChanged: (value) {
                            setState(() {
                              textOptions.style.fontStyle = value.first;
                              widget.onTextUpdated();
                            });
                          },
                          segments: const [
                            ButtonSegment<TextElementFontStyle>(
                              value: TextElementFontStyle.normal,
                              label: Text('Normal'),
                            ),
                            ButtonSegment<TextElementFontStyle>(
                              value: TextElementFontStyle.italic,
                              label: Text(
                                'Itálico',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                          selected: {textOptions.style.fontStyle},
                        ),
                      ),
                    ),
                  ),
                  AppCard(
                    titleText: 'Cor do texto',
                    color: textOptions.style.color != null
                        ? ColorUtils.hexToColor(textOptions.style.color!)
                            .withOpacity(.2)
                        : null,
                    actions: [
                      FilledButton(
                        onPressed: () async {
                          final color = await AppColorPicker.dialog(
                            context,
                            color: textOptions.style.color != null
                                ? ColorUtils.hexToColor(
                                    textOptions.style.color!)
                                : null,
                          );
                          if (color != null) {
                            setState(() {
                              textOptions.style.color =
                                  ColorUtils.colorToHex(color);
                              widget.onTextUpdated();
                            });
                          }
                        },
                        child: const Text('Selecionar cor'),
                      ),
                    ],
                    child: Container(
                      height: 50,
                      color: textOptions.style.color != null
                          ? ColorUtils.hexToColor(textOptions.style.color!)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const AppDivider(
            vertical: true,
            height: 400,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.textElement.content,
                style: textElementStyleTranslator(
                  textOptions.style,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return ResponsivinessWidget(
      width: 900,
      height: 400,
      responsiviness: widget.textElement.responsiviness,
      onUpdated: widget.onTextUpdated,
      xsChild: settingsWidget(widget.textElement.responsiviness.xs),
      smChild: settingsWidget(widget.textElement.responsiviness.sm),
      mdChild: settingsWidget(widget.textElement.responsiviness.md),
      lgChild: settingsWidget(widget.textElement.responsiviness.lg),
      xlChild: settingsWidget(widget.textElement.responsiviness.xl),
      xxlChild: settingsWidget(widget.textElement.responsiviness.xxl),
    );
  }
}
