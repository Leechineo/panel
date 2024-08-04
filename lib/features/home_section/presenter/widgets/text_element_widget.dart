import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart'
    as section_entity;
import 'package:leechineo_panel/features/home_section/domain/entities/text_element.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/text_responsiviness_settings.dart';
import 'package:leechineo_panel/features/home_section/utils/text_element_style_translator.dart';

class TextElementWidget extends StatefulWidget {
  final TextElement textElement;
  final ResponsivinessTextOptions responsiviness;
  final void Function({
    required section_entity.Element element,
    section_entity.Element? parent,
  }) onElementDeleted;
  final section_entity.Element? parent;
  final void Function() onElementUpdated;

  const TextElementWidget({
    required this.textElement,
    required this.onElementDeleted,
    required this.responsiviness,
    required this.onElementUpdated,
    this.parent,
    super.key,
  });

  @override
  State<TextElementWidget> createState() => _TextElementWidgetState();
}

class _TextElementWidgetState extends State<TextElementWidget> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: widget.textElement.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElementWidget(
      element: widget.textElement,
      onElementDeleted: widget.onElementDeleted,
      responsivinessConfigurator: TextResponsivinessSettings(
        onTextUpdated: () {
          widget.onElementUpdated();
        },
        textElement: widget.textElement,
      ),
      parent: widget.parent,
      child: Column(
        children: [
          Text(
            widget.textElement.content.isEmpty
                ? 'Sem texto'
                : widget.textElement.content,
            style: textElementStyleTranslator(
              widget.responsiviness.style,
            ),
            textAlign: textAlignTranslator(widget.responsiviness.style.align),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: AppCard(
                    borderRadius: BorderRadius.circular(0),
                    actions: [
                      FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Concluir'),
                      ),
                    ],
                    width: 800,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _textEditingController,
                        onChanged: (value) {
                          widget.textElement.content = value;
                          setState(() {});
                        },
                        onFieldSubmitted: (value) {
                          Navigator.pop(context);
                        },
                        maxLines: 8,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
    );
  }
}
