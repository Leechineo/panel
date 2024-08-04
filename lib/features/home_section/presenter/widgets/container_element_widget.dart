import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_all_files_references_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/upload_file_usecase.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/container_element.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart'
    as section_entity;
import 'package:leechineo_panel/features/home_section/presenter/widgets/container_responsiviness_settings.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_render_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_widget.dart';
import 'package:leechineo_panel/features/home_section/utils/element_size_translator_util.dart';

class ContainerElementWidget extends StatefulWidget {
  final ContainerElement containerElement;
  final GetFileUrlUseCase getFileUrlUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final GetAllFileReferencesUseCase getAllFileReferencesUseCase;
  final ResponsivinessContainerOptions responsiviness;
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

  const ContainerElementWidget({
    required this.containerElement,
    required this.getFileUrlUseCase,
    required this.getAllFileReferencesUseCase,
    required this.uploadFileUseCase,
    required this.onImageSelected,
    required this.onAddElement,
    required this.onElementUpdated,
    required this.onElementDeleted,
    required this.responsiviness,
    this.parent,
    super.key,
  });

  @override
  State<ContainerElementWidget> createState() => _ContainerElementWidgetState();
}

class _ContainerElementWidgetState extends State<ContainerElementWidget> {
  @override
  Widget build(BuildContext context) {
    return ElementWidget(
      width: ElementSizeTranslatorUtil.convertSize(
        widget.responsiviness.width,
        context,
      ),
      height: ElementSizeTranslatorUtil.convertSize(
        widget.responsiviness.height,
        context,
      ),
      element: widget.containerElement,
      onAddElement: widget.onAddElement,
      onElementDeleted: widget.onElementDeleted,
      parent: widget.parent,
      responsivinessConfigurator: ContainerResponsivinessSettings(
        containerElement: widget.containerElement,
        onElementUpdated: () {
          widget.onElementUpdated();
        },
      ),
      child: SizedBox(
        child: Builder(
          builder: (context) {
            if (widget.containerElement.child != null) {
              return ElementRenderWidget(
                element: widget.containerElement.child!,
                parent: widget.containerElement,
                getAllFileReferencesUseCase: widget.getAllFileReferencesUseCase,
                getFileUrlUseCase: widget.getFileUrlUseCase,
                uploadFileUseCase: widget.uploadFileUseCase,
                onImageSelected: widget.onImageSelected,
                onAddElement: widget.onAddElement,
                onElementUpdated: widget.onElementUpdated,
                onElementDeleted: widget.onElementDeleted,
              );
            }
            return Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                child: Center(
                  child: Column(
                    children: [
                      const AppIlustration(
                        AppIlustrations.wellDone,
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
          },
        ),
      ),
    );
  }
}
