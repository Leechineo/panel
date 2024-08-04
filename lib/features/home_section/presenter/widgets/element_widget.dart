import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/container_element.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart'
    as section_entity;
import 'package:leechineo_panel/features/home_section/domain/entities/text_element.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_picker.dart';

class ElementWidget extends StatelessWidget {
  final section_entity.Element element;
  final void Function({
    required section_entity.Element element,
    section_entity.Element? parent,
  }) onElementDeleted;
  final void Function(
    section_entity.Elements elementType,
    section_entity.Element element,
  )? onAddElement;
  final Widget? responsivinessConfigurator;
  final Widget? child;
  final double? width;
  final double? height;
  final section_entity.Element? parent;
  const ElementWidget({
    required this.element,
    required this.onElementDeleted,
    this.parent,
    this.onAddElement,
    this.width,
    this.height,
    this.child,
    this.responsivinessConfigurator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String getTitle({
      bool withArticle = false,
    }) {
      String article = 'o';
      String title = 'Elemento desconhecido';
      if (element is section_entity.RowElement) {
        title = 'Linha';
        article = 'a';
      }
      if (element is section_entity.ColumnElement) {
        title = 'Coluna';
        article = 'a';
      }
      if (element is ContainerElement) {
        title = 'Container';
        article = 'o';
      }
      if (element is section_entity.ImageElement) {
        title = 'Imagem';
        article = 'a';
      }
      if (element is TextElement) {
        title = 'Texto';
        article = 'o';
      }
      if (withArticle) {
        return '$article ${title.toLowerCase()}';
      }
      return title;
    }

    void deleteDialog({bool deleteParent = false}) {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: AppCard(
            width: 300,
            height: 150,
            titleText: 'Deseja apagar ${getTitle(withArticle: true)}?',
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  onElementDeleted(element: element, parent: parent);
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.red,
                  ),
                ),
                child: const Text(
                  'Apagar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return AppCard(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(0),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Tooltip(
              message: element.id,
              child: Text(
                getTitle(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    deleteDialog();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  tooltip: 'Apagar elemento',
                ),
                if (onAddElement != null)
                  Tooltip(
                    message: 'Adicionar elemento',
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: ElementPicker(
                              onSelected: (elementType) {
                                onAddElement?.call(elementType, element);
                              },
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                if (responsivinessConfigurator != null)
                  Tooltip(
                    message: 'Configurar responsividade',
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: responsivinessConfigurator,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}
