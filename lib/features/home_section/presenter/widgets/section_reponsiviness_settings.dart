import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/responsiviness_widget.dart';

class SectionResponsivinessSettings extends StatefulWidget {
  final SectionEntity section;
  final void Function(bool value, ElementScreenSizes screenSize)
      onHiddenUpdated;
  final void Function() onUpdated;
  const SectionResponsivinessSettings({
    required this.section,
    required this.onHiddenUpdated,
    required this.onUpdated,
    super.key,
  });

  @override
  State<SectionResponsivinessSettings> createState() =>
      _SectionResponsivinessSettingsState();
}

class _SectionResponsivinessSettingsState
    extends State<SectionResponsivinessSettings> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          Widget settingsWidget(ElementScreenSizes screenSize) {
            ElementDisplay displayValue(ElementScreenSizes screenSize) {
              switch (screenSize) {
                case ElementScreenSizes.xs:
                  return widget.section.responsiviness.xs.display;
                case ElementScreenSizes.sm:
                  return widget.section.responsiviness.sm.display;
                case ElementScreenSizes.md:
                  return widget.section.responsiviness.md.display;
                case ElementScreenSizes.lg:
                  return widget.section.responsiviness.lg.display;
                case ElementScreenSizes.xl:
                  return widget.section.responsiviness.xl.display;
                case ElementScreenSizes.xxl:
                  return widget.section.responsiviness.xxl.display;
              }
            }

            bool hiddenValue(ElementDisplay display) {
              switch (display) {
                case ElementDisplay.hidden:
                  return true;
                case ElementDisplay.show:
                  return false;
              }
            }

            return Column(
              children: [
                SwitchListTile(
                  thumbIcon: WidgetStatePropertyAll(
                    Icon(
                      hiddenValue(displayValue(screenSize))
                          ? Icons.check
                          : Icons.close,
                    ),
                  ),
                  value: hiddenValue(
                    displayValue(
                      screenSize,
                    ),
                  ),
                  onChanged: (value) {
                    widget.onHiddenUpdated(value, screenSize);
                    setState(() {});
                  },
                  title: const Text(
                    'Ocultar seção',
                  ),
                ),
              ],
            );
          }

          return ResponsivinessWidget(
            width: 600,
            height: 150,
            responsiviness: widget.section.responsiviness,
            onUpdated: widget.onUpdated,
            xsChild: settingsWidget(ElementScreenSizes.xs),
            smChild: settingsWidget(ElementScreenSizes.sm),
            mdChild: settingsWidget(ElementScreenSizes.md),
            lgChild: settingsWidget(ElementScreenSizes.lg),
            xlChild: settingsWidget(ElementScreenSizes.xl),
            xxlChild: settingsWidget(ElementScreenSizes.xxl),
          );
        },
      ),
    );
  }
}
