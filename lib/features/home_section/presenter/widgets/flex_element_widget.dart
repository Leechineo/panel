import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_all_files_references_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/upload_file_usecase.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart'
    as section_entity;
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_render_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/flex_responsiviness_settings.dart';

class FlexElementWidget extends StatefulWidget {
  final section_entity.Element element;
  final GetFileUrlUseCase getFileUrlUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final GetAllFileReferencesUseCase getAllFileReferencesUseCase;
  final section_entity.ResponsivinessFlexOptions responsiviness;
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
  const FlexElementWidget({
    required this.element,
    required this.getFileUrlUseCase,
    required this.getAllFileReferencesUseCase,
    required this.uploadFileUseCase,
    required this.onImageSelected,
    required this.onAddElement,
    required this.onElementUpdated,
    required this.responsiviness,
    required this.onElementDeleted,
    this.parent,
    super.key,
  });

  @override
  State<FlexElementWidget> createState() => _FlexElementWidgetState();
}

class _FlexElementWidgetState extends State<FlexElementWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.element.children == null) {
      return Container();
    }
    MainAxisAlignment mainAxisAlignment() {
      switch (widget.responsiviness.justify) {
        case section_entity.ElementAlignment.start:
          return MainAxisAlignment.start;
        case section_entity.ElementAlignment.end:
          return MainAxisAlignment.end;
        case section_entity.ElementAlignment.center:
          return MainAxisAlignment.center;
        case section_entity.ElementAlignment.spaceBetween:
          return MainAxisAlignment.spaceBetween;
        case section_entity.ElementAlignment.spaceAround:
          return MainAxisAlignment.spaceAround;
        case section_entity.ElementAlignment.spaceEvenly:
          return MainAxisAlignment.spaceEvenly;
      }
    }

    CrossAxisAlignment crossAxisAlignment() {
      switch (widget.responsiviness.align) {
        case section_entity.ElementAlignment.start:
          return CrossAxisAlignment.start;
        case section_entity.ElementAlignment.end:
          return CrossAxisAlignment.end;
        case section_entity.ElementAlignment.center:
          return CrossAxisAlignment.center;
        default:
          return CrossAxisAlignment.start;
      }
    }

    return ElementWidget(
      element: widget.element,
      onElementDeleted: widget.onElementDeleted,
      onAddElement: widget.onAddElement,
      responsivinessConfigurator: FlexResponsivinessSettings(
        element: widget.element,
        onElementUpdated: widget.onElementUpdated,
      ),
      parent: widget.parent,
      child: Builder(
        builder: (context) {
          if (widget.element.children!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                child: Center(
                  child: Column(
                    children: [
                      const AppIlustration(
                        AppIlustrations.post,
                        width: 200,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Nenhum elemento adicionado',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          final children = widget.element.children!
              .map<Widget>(
                (e) => ElementRenderWidget(
                  parent: widget.element,
                  element: e,
                  getAllFileReferencesUseCase:
                      widget.getAllFileReferencesUseCase,
                  getFileUrlUseCase: widget.getFileUrlUseCase,
                  uploadFileUseCase: widget.uploadFileUseCase,
                  onImageSelected: widget.onImageSelected,
                  onAddElement: widget.onAddElement,
                  onElementUpdated: widget.onElementUpdated,
                  onElementDeleted: ({parent, required element}) {
                    widget.onElementDeleted(
                      element: element,
                      parent: widget.element.children != null &&
                              widget.element.children!.contains(element)
                          ? widget.element
                          : parent,
                    );
                  },
                ),
              )
              .toList();
          if (widget.element is section_entity.ColumnElement) {
            return Column(
              mainAxisAlignment: mainAxisAlignment(),
              crossAxisAlignment: crossAxisAlignment(),
              children: children,
            );
          }
          return Row(
            mainAxisAlignment: mainAxisAlignment(),
            crossAxisAlignment: crossAxisAlignment(),
            children: children,
          );
        },
      ),
    );
  }
}
