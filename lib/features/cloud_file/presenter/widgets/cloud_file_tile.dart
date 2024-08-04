import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_exporer_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/widgets/cloud_file_icon.dart';

class CloudFileTile extends StatelessWidget {
  final AppFileExplorer item;
  final String url;
  final bool Function(FileReferenceEntity file) selected;
  final void Function(String name)? onFolderSelected;
  final void Function()? onPreviousPathTapped;
  final void Function(FileReferenceEntity file)? onFileSelected;

  late final FileReferenceEntity appFileInstance;

  CloudFileTile({
    required this.item,
    required this.selected,
    required this.url,
    this.onFolderSelected,
    this.onPreviousPathTapped,
    this.onFileSelected,
    super.key,
  }) {
    appFileInstance = item.toFileReference();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (item.type == 'folder') {
          onFolderSelected?.call(item.name);
        }
        if (item.type == 'back_folder') {
          onPreviousPathTapped?.call();
        }
        if (item.type == 'file') {
          onFileSelected?.call(appFileInstance);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            AnimatedOpacity(
              opacity: selected(appFileInstance) ? 1 : 0,
              duration: const Duration(
                milliseconds: 80,
              ),
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 80,
                ),
                curve: Curves.easeInOut,
                width: selected(appFileInstance) ? 25 : 0,
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).buttonTheme.colorScheme!.primary,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            CloudFileIcon(
              item: item,
              url: url,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              item.name,
            ),
          ],
        ),
      ),
    );
  }
}
