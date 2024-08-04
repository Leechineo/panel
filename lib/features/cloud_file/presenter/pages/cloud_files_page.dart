import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_page_controller.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/widgets/cloud_file_tile.dart';

class CloudFilesPage extends StatelessWidget {
  final CloudFilesPageController controller;
  final void Function(List<FileReferenceEntity> files) onSelectionChanged;
  const CloudFilesPage({
    required this.controller,
    required this.onSelectionChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(
      builder: (context, data) {
        if (data.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (data.explorerItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppIlustration(
                  AppIlustrations.folderFiles,
                  width: 250,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Sem arquivos',
                  style: Theme.of(context).textTheme.headlineMedium,
                )
              ],
            ),
          );
        }
        return ListView.separated(
          itemBuilder: (context, index) => CloudFileTile(
            item: data.explorerItems[index],
            url: controller.methods.getFileUrl(data.explorerItems[index].id),
            onFileSelected: (file) {
              final items = controller.methods.toggleFileSelection(file);
              onSelectionChanged(items);
            },
            onFolderSelected: (name) {
              controller.methods.goToPath(name);
            },
            onPreviousPathTapped: () {
              controller.methods.goToPreviousPath();
            },
            selected: (file) {
              return controller.methods.getFileSelectionState(file);
            },
          ),
          separatorBuilder: (context, index) => const AppDivider(),
          itemCount: data.explorerItems.length,
        );
      },
    );
  }
}
