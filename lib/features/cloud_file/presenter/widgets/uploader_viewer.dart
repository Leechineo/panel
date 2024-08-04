import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/widgets/uploader_viewer_tile.dart';

class UploaderViewer extends StatelessWidget {
  final List<File> files;
  final List<File> selectedFiles;
  final void Function(File file) onFileSelected;
  const UploaderViewer({
    required this.files,
    required this.selectedFiles,
    required this.onFileSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (files.isEmpty) {
        return const AppIlustration(
          AppIlustrations.upload,
          width: 200,
        );
      }
      return Wrap(
        alignment: WrapAlignment.center,
        children: files
            .map(
              (file) => UploaderViewerTile(
                file: file,
                selected: selectedFiles.contains(file),
                onToggleSelection: (file) => onFileSelected(file),
              ),
            )
            .toList(),
      );
    });
  }
}
