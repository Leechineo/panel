import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/container_element.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/responsiviness_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/size_editor_widget.dart';

class ContainerResponsivinessSettings extends StatefulWidget {
  final ContainerElement containerElement;
  final void Function() onElementUpdated;
  const ContainerResponsivinessSettings({
    required this.containerElement,
    required this.onElementUpdated,
    super.key,
  });

  @override
  State<ContainerResponsivinessSettings> createState() =>
      _ContainerResponsivinessSettingsState();
}

class _ContainerResponsivinessSettingsState
    extends State<ContainerResponsivinessSettings> {
  @override
  Widget build(BuildContext context) {
    Widget settingsWidget(ResponsivinessContainerOptions containerOptions) {
      return Column(
        children: [
          AppCard(
            borderless: true,
            titleText: 'Largura',
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SizeEditorWidget(
                  elementSize: containerOptions.width,
                  onElementUpdated: widget.onElementUpdated,
                ),
              ),
            ),
          ),
          AppCard(
            borderless: true,
            titleText: 'Altura',
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SizeEditorWidget(
                  elementSize: containerOptions.height,
                  onElementUpdated: widget.onElementUpdated,
                ),
              ),
            ),
          ),
          AppCard(
            borderless: true,
            titleText: 'Espaçamento interno',
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    SegmentedButton(
                      segments: const [
                        ButtonSegment(
                          value: ElementSpacingType.all,
                          label: Text('Todos'),
                        ),
                        ButtonSegment(
                          value: ElementSpacingType.only,
                          label: Text('Apenas'),
                        ),
                        ButtonSegment(
                          value: ElementSpacingType.symetric,
                          label: Text('Simétrico'),
                        ),
                      ],
                      selected: {containerOptions.padding.type},
                      onSelectionChanged: (value) {
                        setState(() {
                          containerOptions.padding.type = value.first;
                        });
                        widget.onElementUpdated();
                      },
                    ),
                    ...[
                      Row(
                        children: [
                          Builder(builder: (context) {
                            switch (containerOptions.padding.type) {
                              case ElementSpacingType.only:
                                return const Text('Topo');
                              case ElementSpacingType.all:
                                return Container();
                              case ElementSpacingType.symetric:
                                return const Text('Vertical');
                            }
                          }),
                          Expanded(
                            child: Slider(
                              value: () {
                                if (containerOptions.padding.type ==
                                    ElementSpacingType.only) {
                                  return containerOptions.padding.getTop();
                                } else if (containerOptions.padding.type ==
                                    ElementSpacingType.all) {
                                  return containerOptions.padding.getAll();
                                } else {
                                  return containerOptions.padding.getVertical();
                                }
                              }(),
                              min: 0,
                              max: 40,
                              divisions: 10,
                              label: containerOptions.padding
                                  .getTop()
                                  .toInt()
                                  .toString(),
                              onChanged: (value) {
                                setState(() {
                                  if (containerOptions.padding.type ==
                                      ElementSpacingType.only) {
                                    containerOptions.padding.setTop(value);
                                  } else if (containerOptions.padding.type ==
                                      ElementSpacingType.all) {
                                    containerOptions.padding.setAll(value);
                                  } else {
                                    containerOptions.padding.setVertical(value);
                                  }
                                });
                                widget.onElementUpdated();
                              },
                            ),
                          ),
                        ],
                      ),
                      if (containerOptions.padding.type !=
                          ElementSpacingType.all)
                        Row(
                          children: [
                            Builder(builder: (context) {
                              if (containerOptions.padding.type ==
                                  ElementSpacingType.only) {
                                return const Text('Base');
                              }
                              return const Text('Horizontal');
                            }),
                            Expanded(
                              child: Slider(
                                value: () {
                                  if (containerOptions.padding.type ==
                                      ElementSpacingType.only) {
                                    return containerOptions.padding.getBottom();
                                  } else {
                                    return containerOptions.padding
                                        .getHorizontal();
                                  }
                                }(),
                                min: 0,
                                max: 40,
                                divisions: 10,
                                label: containerOptions.padding
                                    .getTop()
                                    .toInt()
                                    .toString(),
                                onChanged: (value) {
                                  setState(() {
                                    if (containerOptions.padding.type ==
                                        ElementSpacingType.only) {
                                      containerOptions.padding.setBottom(value);
                                    } else {
                                      containerOptions.padding
                                          .setHorizontal(value);
                                    }
                                  });
                                  widget.onElementUpdated();
                                },
                              ),
                            ),
                          ],
                        ),
                      if (containerOptions.padding.type ==
                          ElementSpacingType.only)
                        Row(
                          children: [
                            const Text('Esquerda'),
                            Expanded(
                              child: Slider(
                                value: containerOptions.padding.getLeft(),
                                min: 0,
                                max: 40,
                                divisions: 10,
                                label: containerOptions.padding
                                    .getTop()
                                    .toInt()
                                    .toString(),
                                onChanged: (value) {
                                  setState(() {
                                    containerOptions.padding.setLeft(value);
                                  });
                                  widget.onElementUpdated();
                                },
                              ),
                            ),
                          ],
                        ),
                      if (containerOptions.padding.type ==
                          ElementSpacingType.only)
                        Row(
                          children: [
                            const Text('Direita'),
                            Expanded(
                              child: Slider(
                                value: containerOptions.padding.getRight(),
                                min: 0,
                                max: 40,
                                divisions: 10,
                                label: containerOptions.padding
                                    .getTop()
                                    .toInt()
                                    .toString(),
                                onChanged: (value) {
                                  setState(() {
                                    containerOptions.padding.setRight(value);
                                  });
                                  widget.onElementUpdated();
                                },
                              ),
                            ),
                          ],
                        ),
                    ]
                  ],
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
      responsiviness: widget.containerElement.responsiviness,
      onUpdated: widget.onElementUpdated,
      xsChild: settingsWidget(widget.containerElement.responsiviness.xs),
      smChild: settingsWidget(widget.containerElement.responsiviness.sm),
      mdChild: settingsWidget(widget.containerElement.responsiviness.md),
      lgChild: settingsWidget(widget.containerElement.responsiviness.lg),
      xlChild: settingsWidget(widget.containerElement.responsiviness.xl),
      xxlChild: settingsWidget(widget.containerElement.responsiviness.xxl),
    );
  }
}
