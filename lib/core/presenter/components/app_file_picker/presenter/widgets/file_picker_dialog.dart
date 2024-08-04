import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/pages/cloud_files_page.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/pages/selection_manager_page.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/pages/uploader_page.dart';

class FilePickerDialog extends StatefulWidget {
  final CloudFilesMainPageController controller;

  const FilePickerDialog({
    required this.controller,
    super.key,
  });

  @override
  State<FilePickerDialog> createState() => _FilePickerDialogState();
}

class _FilePickerDialogState extends State<FilePickerDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.builder(
      builder: (context, controllers) {
        return Center(
          child: AppCard(
            width: 850,
            height: 370,
            title: TabBar(
              dividerColor: Colors.transparent,
              labelPadding: const EdgeInsets.all(12),
              controller: _tabController,
              tabs: const [
                Icon(
                  Icons.folder,
                ),
                Icon(
                  Icons.cloud,
                ),
                Icon(Icons.check_circle_rounded),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FilledButton(
                        onPressed: () {
                          widget.controller.methods.pickFiles();
                        },
                        child: const Icon(
                          Icons.folder,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      controllers.uploaderPageController.builder(
                        builder: (context, uploaderData) {
                          return FilledButton(
                            onPressed: uploaderData.files.isNotEmpty
                                ? () {
                                    controllers.uploaderPageController.methods
                                        .sendFiles(context);
                                  }
                                : null,
                            child: const Text('Enviar'),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      controllers.selectionManagerPageController.builder(
                        builder: (context, selectorData) {
                          return FilledButton(
                            onPressed: selectorData.files.isNotEmpty
                                ? () {
                                    Navigator.pop<List<FileReferenceEntity>?>(
                                      context,
                                      selectorData.files,
                                    );
                                  }
                                : null,
                            child: const Text('Concluir'),
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: AppDivider(
                          vertical: true,
                          height: 30,
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Fechar'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
            child: TabBarView(
              controller: _tabController,
              children: [
                UploaderPage(
                  controller: controllers.uploaderPageController,
                  onFilesUploaded: (files) {
                    controllers.selectionManagerPageController.methods
                        .addFiles(files);
                    _tabController.animateTo(2);
                  },
                ),
                CloudFilesPage(
                  controller: controllers.cloudFilesPageController,
                  onSelectionChanged: (files) {
                    controllers.selectionManagerPageController.methods
                        .setFiles(files);
                  },
                ),
                SelectionManagerPage(
                  controller: controllers.selectionManagerPageController,
                  onSelectionDeleted: (file) {
                    controllers.cloudFilesPageController.methods
                        .toggleFileSelection(file);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
