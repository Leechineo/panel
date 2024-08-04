import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_exporer_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/widgets/cloud_file_icon.dart';

class SelectionManagerTile extends StatelessWidget {
  final AppFileExplorer file;
  final void Function(FileReferenceEntity file) onSelectionDeleted;
  const SelectionManagerTile({
    required this.file,
    required this.onSelectionDeleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CloudFileIcon(
            item: file,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              file.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          FilledButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => deleteDialog(
                  context,
                  file: file,
                  onFileDeleted: (file) {
                    onSelectionDeleted(file);
                  },
                ),
              );
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            child: const Icon(Icons.delete),
          ),
          const SizedBox(
            width: 28,
          )
        ],
      ),
    );
  }
}

Widget deleteDialog(
  BuildContext context, {
  required AppFileExplorer file,
  required void Function(FileReferenceEntity file) onFileDeleted,
}) {
  return Center(
    child: AppCard(
      titleText: 'Você deseja remover o arquivo da seleção?',
      width: 440,
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancelar',
          ),
        ),
        FilledButton(
          onPressed: () {
            onFileDeleted(file.toFileReference());
            Navigator.pop(context);
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red),
          ),
          child: const Text(
            'Deletar',
          ),
        ),
      ],
    ),
  );
}
