import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_alert.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_expandable.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/element_size.dart';

class SizeEditorWidget extends StatefulWidget {
  final ElementSize elementSize;
  final void Function() onElementUpdated;
  const SizeEditorWidget({
    required this.elementSize,
    required this.onElementUpdated,
    super.key,
  });

  @override
  State<SizeEditorWidget> createState() => _SizeEditorWidgetState();
}

class _SizeEditorWidgetState extends State<SizeEditorWidget> {
  List<FocusNode> focusNodes = [];

  @override
  void dispose() {
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeController = TextEditingController(
      text: widget.elementSize.value.toInt().toString(),
    );
    final FocusNode sizeFocusNode = FocusNode();
    focusNodes.add(sizeFocusNode);
    sizeFocusNode.addListener(() {
      if (!sizeFocusNode.hasFocus) {
        setState(() {
          widget.elementSize.value = double.parse(sizeController.text);
        });
        widget.onElementUpdated();
      }
    });
    double realTimeSizeValue = widget.elementSize.value;
    return Column(
      children: [
        SegmentedButton<ElementSizeType>(
          segments: const [
            ButtonSegment(
              value: ElementSizeType.fixed,
              label: Text(
                'Fixo',
              ),
            ),
            ButtonSegment(
              value: ElementSizeType.virtualWidth,
              label: Text(
                'Largura da Janela',
              ),
            ),
            ButtonSegment(
              value: ElementSizeType.virtualHeight,
              label: Text(
                'Altura da Janela',
              ),
            ),
          ],
          selected: {widget.elementSize.type},
          onSelectionChanged: (value) {
            setState(() {
              if (widget.elementSize.value > 150 &&
                  value.first != ElementSizeType.fixed) {
                widget.elementSize.value = 100;
              }
              if (widget.elementSize.value < 0) {
                widget.elementSize.value = 10;
              }
              if (widget.elementSize.value < 300 &&
                  value.first == ElementSizeType.fixed) {
                widget.elementSize.value = 300;
              }
              widget.elementSize.type = value.first;
            });
            widget.onElementUpdated();
          },
        ),
        if (widget.elementSize.type == ElementSizeType.virtualHeight ||
            widget.elementSize.type == ElementSizeType.virtualWidth)
          Slider(
            min: 1,
            max: 150,
            divisions: 149,
            label: '${widget.elementSize.value.toInt().toString()}%',
            value: widget.elementSize.value,
            onChanged: (value) {
              setState(() {
                widget.elementSize.value = value;
              });
              widget.onElementUpdated();
            },
          ),
        if (widget.elementSize.type == ElementSizeType.fixed)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 4,
              top: 16,
              right: 24,
              left: 12,
            ),
            child: Row(
              children: [
                Tooltip(
                  message: 'Tamanho dinâmico',
                  child: Checkbox(
                    value: widget.elementSize.value == -1,
                    visualDensity: VisualDensity.compact,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          widget.elementSize.value = -1;
                        } else {
                          widget.elementSize.value = 300;
                        }
                      });
                      widget.onElementUpdated();
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    focusNode: sizeFocusNode,
                    controller: sizeController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      enabled: widget.elementSize.value != -1,
                      border: const OutlineInputBorder(),
                      labelText: 'Tamanho',
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        AppExpandable(
          isExpanded: realTimeSizeValue == -1,
          body: const Padding(
            padding: EdgeInsets.only(right: 20, left: 40),
            child: AppAlert(
              type: AlertType.warning,
              title: 'Tamanho dinâmico',
              message: 'O valor -1 aplica tamanho dinâmico ao container',
            ),
          ),
        ),
      ],
    );
  }
}
