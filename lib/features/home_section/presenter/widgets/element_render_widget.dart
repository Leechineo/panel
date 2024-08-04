import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/utils/display_helper.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_all_files_references_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/upload_file_usecase.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/container_element.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart'
    as section_entity;
import 'package:leechineo_panel/features/home_section/domain/entities/text_element.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/container_element_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/image_element_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/flex_element_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/text_element_widget.dart';

class ElementRenderWidget extends StatefulWidget {
  final section_entity.Element element;
  final GetFileUrlUseCase getFileUrlUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final GetAllFileReferencesUseCase getAllFileReferencesUseCase;
  final void Function(
    section_entity.Elements elementType,
    section_entity.Element element,
  ) onAddElement;
  final void Function(
    FileReferenceEntity file,
    section_entity.Element element,
  ) onImageSelected;
  final void Function() onElementUpdated;
  final void Function({
    required section_entity.Element element,
    section_entity.Element? parent,
  }) onElementDeleted;
  final section_entity.Element? parent;
  const ElementRenderWidget({
    required this.element,
    required this.getFileUrlUseCase,
    required this.getAllFileReferencesUseCase,
    required this.uploadFileUseCase,
    required this.onImageSelected,
    required this.onAddElement,
    required this.onElementUpdated,
    required this.onElementDeleted,
    this.parent,
    super.key,
  });

  @override
  State<ElementRenderWidget> createState() => _ElementRenderWidgetState();
}

class _ElementRenderWidgetState extends State<ElementRenderWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final displayHelper = DisplayHelper(context);

        T responsivinessExtractor<T extends section_entity.ResponsivinessItem>(
          section_entity.Responsiviness<T> responsiviness,
        ) {
          if (responsiviness.linked) {
            return responsiviness.xs;
          }
          if (displayHelper.xs) {
            return responsiviness.xs;
          }
          if (displayHelper.sm) {
            return responsiviness.sm;
          }
          if (displayHelper.md) {
            return responsiviness.md;
          }
          if (displayHelper.lg) {
            return responsiviness.lg;
          }
          if (displayHelper.xl) {
            return responsiviness.xl;
          }
          return responsiviness.xxl;
        }

        section_entity.Element? getParent({
          required section_entity.Element element,
          section_entity.Element? parent,
        }) {
          bool isParent(section_entity.Element? checkerElement) {
            if (checkerElement?.child != null &&
                checkerElement?.child == element) {
              return true;
            }
            if (checkerElement?.children != null &&
                checkerElement!.children!.contains(element)) {
              return true;
            }
            return false;
          }

          if (isParent(widget.element)) {
            return widget.element;
          }
          if (isParent(parent)) {
            return parent;
          }
          if (isParent(widget.parent)) {
            return widget.parent;
          }
          return null;
        }

        if (widget.element is section_entity.RowElement ||
            widget.element is section_entity.ColumnElement) {
          return FlexElementWidget(
            parent: widget.parent,
            element: widget.element,
            getAllFileReferencesUseCase: widget.getAllFileReferencesUseCase,
            getFileUrlUseCase: widget.getFileUrlUseCase,
            uploadFileUseCase: widget.uploadFileUseCase,
            onImageSelected: widget.onImageSelected,
            onAddElement: widget.onAddElement,
            onElementUpdated: () {
              widget.onElementUpdated();
              setState(() {});
            },
            responsiviness: responsivinessExtractor(
              widget.element.responsiviness as section_entity
                  .Responsiviness<section_entity.ResponsivinessFlexOptions>,
            ),
            onElementDeleted: ({parent, required element}) {
              widget.onElementDeleted(
                element: element,
                parent: getParent(
                  element: element,
                  parent: parent,
                ),
              );
              setState(() {});
            },
          );
        }
        if (widget.element is ContainerElement) {
          return ContainerElementWidget(
            parent: widget.parent,
            containerElement: widget.element as ContainerElement,
            getAllFileReferencesUseCase: widget.getAllFileReferencesUseCase,
            getFileUrlUseCase: widget.getFileUrlUseCase,
            uploadFileUseCase: widget.uploadFileUseCase,
            onImageSelected: widget.onImageSelected,
            onAddElement: widget.onAddElement,
            onElementUpdated: widget.onElementUpdated,
            responsiviness: responsivinessExtractor(
              widget.element.responsiviness as section_entity
                  .Responsiviness<ResponsivinessContainerOptions>,
            ),
            onElementDeleted: ({parent, required element}) {
              widget.onElementDeleted(
                element: element,
                parent: getParent(element: element, parent: parent),
              );
              setState(() {});
            },
          );
        }
        if (widget.element is section_entity.ImageElement) {
          return ImageElementWidget(
            imageElement: widget.element as section_entity.ImageElement,
            getFileUrlUseCase: widget.getFileUrlUseCase,
            getAllFileReferencesUseCase: widget.getAllFileReferencesUseCase,
            uploadFileUseCase: widget.uploadFileUseCase,
            onImageSelected: widget.onImageSelected,
            onAddElement: widget.onAddElement,
            responsiviness: responsivinessExtractor(
              widget.element.responsiviness as section_entity
                  .Responsiviness<section_entity.ResponsivinessImageOptions>,
            ),
            onElementDeleted: ({required element, parent}) {
              widget.onElementDeleted(
                element: element,
                parent: getParent(element: element, parent: parent),
              );
              setState(() {});
            },
            onElementUpdated: widget.onElementUpdated,
            parent: widget.parent,
          );
        }
        if (widget.element is TextElement) {
          return TextElementWidget(
            textElement: widget.element as TextElement,
            onElementDeleted: ({required element, parent}) {
              widget.onElementDeleted(
                element: element,
                parent: getParent(element: element, parent: parent),
              );
              setState(() {});
            },
            parent: widget.parent,
            onElementUpdated: widget.onElementUpdated,
            responsiviness: responsivinessExtractor(
              widget.element.responsiviness
                  as section_entity.Responsiviness<ResponsivinessTextOptions>,
            ),
          );
        }
        return AppCard(
          titleText: 'Elemento desconhecido',
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                widget.element.runtimeType.toString(),
              ),
            ),
          ),
        );
      },
    );
  }
}
