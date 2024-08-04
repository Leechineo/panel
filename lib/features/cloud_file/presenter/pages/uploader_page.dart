import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_expandable.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/uploader_page_controller.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/widgets/uploader_viewer.dart';

class UploaderPage extends StatelessWidget {
  final UploaderPageController controller;
  final void Function(List<FileReferenceEntity> files) onFilesUploaded;
  const UploaderPage({
    required this.controller,
    required this.onFilesUploaded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(
      builder: (context, data) {
        return Column(
          children: [
            AppExpandable(
              isExpanded: data.files.isNotEmpty,
              body: AppCard(
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilledButton(
                        onPressed: () {
                          controller.methods.selectAllFiles();
                        },
                        child: const Icon(
                          Icons.select_all_rounded,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      FilledButton(
                        onPressed: data.selectedFiles.isNotEmpty
                            ? () => showDialog(
                                  context: context,
                                  builder: (context) => Center(
                                    child: AppCard(
                                      width: 450,
                                      titleText:
                                          'Deseja deletar os arquivos selecionados?',
                                      actions: [
                                        FilledButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            'Cancelar',
                                          ),
                                        ),
                                        FilledButton(
                                          onPressed:
                                              data.selectedFiles.isNotEmpty
                                                  ? () {
                                                      controller.methods
                                                          .deleteSelectedFiles();
                                                      Navigator.pop(context);
                                                    }
                                                  : null,
                                          style: data.selectedFiles.isNotEmpty
                                              ? const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                    Colors.red,
                                                  ),
                                                )
                                              : null,
                                          child: const Text(
                                            'Deletar',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            : null,
                        style: data.selectedFiles.isNotEmpty
                            ? const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Colors.red,
                                ),
                              )
                            : null,
                        child: const Icon(
                          Icons.delete,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UploaderViewer(
                        files: data.files,
                        selectedFiles: data.selectedFiles,
                        onFileSelected: (file) {
                          controller.methods.toggleFileSelection(file);
                        },
                      ),
                      if (data.customizablePath)
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Text(data.prePath),
                              const SizedBox(
                                width: 12,
                              ),
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Caminho customizado',
                                    isDense: true,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      eventListener: (context, event, data) {
        if (event.id == 'uploadedFiles') {
          onFilesUploaded(event.data);
        }
      },
    );
  }
}
