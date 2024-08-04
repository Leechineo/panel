import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/responsiviness_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/size_editor_widget.dart';

class ImageResponsivinessSettings extends StatefulWidget {
  final ImageElement imageElement;
  final void Function() onElementUpdated;
  const ImageResponsivinessSettings({
    required this.imageElement,
    required this.onElementUpdated,
    super.key,
  });

  @override
  State<ImageResponsivinessSettings> createState() =>
      _ImageResponsivinessSettingsState();
}

class _ImageResponsivinessSettingsState
    extends State<ImageResponsivinessSettings> {
  @override
  Widget build(BuildContext context) {
    Widget settingsWidget(ResponsivinessImageOptions imageOptions) {
      return Column(
        children: [
          AppCard(
            borderless: true,
            titleText: 'Largura',
            child: SizeEditorWidget(
              elementSize: imageOptions.width,
              onElementUpdated: widget.onElementUpdated,
            ),
          ),
          AppCard(
            borderless: true,
            titleText: 'Altura',
            child: SizeEditorWidget(
              elementSize: imageOptions.height,
              onElementUpdated: widget.onElementUpdated,
            ),
          ),
        ],
      );
    }

    return ResponsivinessWidget(
      width: 900,
      height: 400,
      responsiviness: widget.imageElement.responsiviness,
      onUpdated: widget.onElementUpdated,
      xsChild: settingsWidget(widget.imageElement.responsiviness.xs),
      smChild: settingsWidget(widget.imageElement.responsiviness.sm),
      mdChild: settingsWidget(widget.imageElement.responsiviness.md),
      lgChild: settingsWidget(widget.imageElement.responsiviness.lg),
      xlChild: settingsWidget(widget.imageElement.responsiviness.xl),
      xxlChild: settingsWidget(widget.imageElement.responsiviness.xxl),
    );
  }
}
