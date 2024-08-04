import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_all_files_references_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/upload_file_usecase.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart'
    as section_entity;
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_picker.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/element_render_widget.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/section_reponsiviness_settings.dart';

class Section extends StatefulWidget {
  final section_entity.SectionEntity section;
  final void Function(
    bool value,
    section_entity.ElementScreenSizes screenSize,
  ) onHiddenUpdated;
  final List<section_entity.Element> elements;
  final void Function(
    section_entity.Elements element,
    String? elementId,
    String sectionId,
  ) addElement;
  final GetFileUrlUseCase getFileUrlUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final GetAllFileReferencesUseCase getAllFileReferencesUseCase;
  final section_entity.Element? parent;
  final void Function(
    section_entity.Elements elementType,
    section_entity.Element element,
  ) onAddElement;
  final void Function(
    FileReferenceEntity file,
    section_entity.Element element,
  ) onImageSelected;
  final void Function(
    section_entity.SectionEntity section,
  ) onDeleteSection;
  final void Function() onElementUpdated;
  final void Function({
    required section_entity.Element element,
    section_entity.Element? parent,
  }) onElementDeleted;
  const Section({
    required this.section,
    required this.onHiddenUpdated,
    required this.elements,
    required this.addElement,
    required this.getFileUrlUseCase,
    required this.getAllFileReferencesUseCase,
    required this.uploadFileUseCase,
    required this.onImageSelected,
    required this.onAddElement,
    required this.onDeleteSection,
    required this.onElementUpdated,
    required this.onElementDeleted,
    this.parent,
    super.key,
  });

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderRadius: BorderRadius.circular(0),
      title: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Tooltip(
              message: 'Deletar seção',
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                      child: AppCard(
                        width: 300,
                        height: 150,
                        titleText: 'Deseja apagar a seção?',
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
                              widget.onDeleteSection(widget.section);
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
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
            Tooltip(
              message: 'Adicionar elemento',
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                      child: ElementPicker(
                        onSelected: (element) {
                          widget.addElement.call(
                            element,
                            null,
                            widget.section.id,
                          );
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
            Tooltip(
              message: 'Configurar responsividade',
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SizedBox(
                      width: 350,
                      height: 150,
                      child: SectionResponsivinessSettings(
                        section: widget.section,
                        onUpdated: () {
                          setState(() {});
                        },
                        onHiddenUpdated: (value, screenSize) =>
                            widget.onHiddenUpdated(
                          value,
                          screenSize,
                        ),
                      ),
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
      ),
      child: Builder(builder: (context) {
        if (widget.elements.isEmpty) {
          return SizedBox(
            height: 250,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppIlustration(
                    AppIlustrations.creativeTeam,
                    width: 250,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Sem elementos adicionados',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.section.elements
              .map(
                (e) => ElementRenderWidget(
                  element: e,
                  parent: widget.parent,
                  getAllFileReferencesUseCase:
                      widget.getAllFileReferencesUseCase,
                  getFileUrlUseCase: widget.getFileUrlUseCase,
                  uploadFileUseCase: widget.uploadFileUseCase,
                  onImageSelected: widget.onImageSelected,
                  onAddElement: widget.onAddElement,
                  onElementUpdated: widget.onElementUpdated,
                  onElementDeleted: widget.onElementDeleted,
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
