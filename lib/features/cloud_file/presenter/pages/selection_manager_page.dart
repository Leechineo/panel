import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_exporer_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/selection_manager_page_controller.dart';

import '../widgets/selection_manager_tile.dart';

class SelectionManagerPage extends StatelessWidget {
  final SelectionManagerPageController controller;
  final void Function(FileReferenceEntity file) onSelectionDeleted;
  const SelectionManagerPage({
    required this.controller,
    required this.onSelectionDeleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(
      builder: (context, data) {
        if (data.files.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppIlustration(
                  AppIlustrations.myFiles,
                  width: 300,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Nenhum arquivo selecionado',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          );
        }
        return ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            controller.methods.reorderFiles(oldIndex, newIndex);
          },
          children: [
            ...data.files
                .map(
                  (file) => SelectionManagerTile(
                    key: Key(file.id),
                    file: AppFileExplorer.fromFileReference(file),
                    onSelectionDeleted: (file) {
                      controller.methods.deleteFileSelection(file);
                      onSelectionDeleted(file);
                    },
                  ),
                )
                .toList()
          ],
        );
      },
    );
  }
}
