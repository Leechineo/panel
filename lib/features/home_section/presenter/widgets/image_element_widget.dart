import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/app_file_picker/app_file_picker.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_picker_extension_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_all_files_references_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/upload_file_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart'
    as section_entity;
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_render_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/image_responsiviness_settings.dart';
import 'package:leechineo_panel/features/home_section/utils/element_size_translator_util.dart';

class ImageElementWidget extends StatefulWidget {
  final GetFileUrlUseCase getFileUrlUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final GetAllFileReferencesUseCase getAllFileReferencesUseCase;
  final void Function(
    FileReferenceEntity file,
    section_entity.Element element,
  ) onImageSelected;
  final section_entity.ImageElement imageElement;
  final void Function(
    section_entity.Elements elementType,
    section_entity.Element element,
  ) onAddElement;
  final void Function({
    required section_entity.Element element,
    section_entity.Element? parent,
  }) onElementDeleted;
  final void Function() onElementUpdated;
  final section_entity.ResponsivinessImageOptions responsiviness;
  final section_entity.Element? parent;
  const ImageElementWidget({
    required this.imageElement,
    required this.getFileUrlUseCase,
    required this.getAllFileReferencesUseCase,
    required this.uploadFileUseCase,
    required this.onImageSelected,
    required this.onAddElement,
    required this.onElementDeleted,
    required this.onElementUpdated,
    required this.responsiviness,
    this.parent,
    super.key,
  });

  @override
  State<ImageElementWidget> createState() => _ImageElementWidgetState();
}

class _ImageElementWidgetState extends State<ImageElementWidget> {
  late final CloudFilesMainPageController controller;
  @override
  void initState() {
    super.initState();
    controller = CloudFilesMainPageController(
      uploadFileUseCase: widget.uploadFileUseCase,
      getAllFileReferencesUseCase: widget.getAllFileReferencesUseCase,
      getFileUrlUseCase: widget.getFileUrlUseCase,
      allowedExtensions: [
        AppFilePickerExtension.png,
        AppFilePickerExtension.jpeg,
        AppFilePickerExtension.jpg,
      ],
      multiple: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElementWidget(
      element: widget.imageElement,
      onElementDeleted: widget.onElementDeleted,
      parent: widget.parent,
      responsivinessConfigurator: ImageResponsivinessSettings(
        imageElement: widget.imageElement,
        onElementUpdated: widget.onElementUpdated,
      ),
      child: Builder(
        builder: (context) {
          if (widget.imageElement.fileId == null) {
            return AppFilePicker(
              controller: controller,
              builder: (context, selector) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppIlustration(
                        AppIlustrations.images,
                        width: 200,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      FilledButton(
                        onPressed: () async {
                          final files = await selector();
                          if (files != null && files.isNotEmpty) {
                            widget.onImageSelected(
                              files.first,
                              widget.imageElement,
                            );
                          }
                        },
                        child: const Text(
                          'Selecionar imagem',
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Stack(
            children: [
              Image.network(
                widget.getFileUrlUseCase(widget.imageElement.fileId!),
                width: ElementSizeTranslatorUtil.convertSize(
                  widget.responsiviness.width,
                  context,
                ),
                height: ElementSizeTranslatorUtil.convertSize(
                  widget.responsiviness.height,
                  context,
                ),
                fit: BoxFit.cover,
              ),
              if (widget.imageElement.child != null)
                ElementRenderWidget(
                  parent: widget.imageElement,
                  element: widget.imageElement.child!,
                  getFileUrlUseCase: widget.getFileUrlUseCase,
                  getAllFileReferencesUseCase:
                      widget.getAllFileReferencesUseCase,
                  uploadFileUseCase: widget.uploadFileUseCase,
                  onImageSelected: widget.onImageSelected,
                  onAddElement: widget.onAddElement,
                  onElementUpdated: widget.onElementUpdated,
                  onElementDeleted: widget.onElementDeleted,
                ),
            ],
          );
        },
      ),
    );
  }
}
