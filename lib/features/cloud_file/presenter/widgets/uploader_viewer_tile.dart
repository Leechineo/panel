import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/utils/file_icon.dart';

class UploaderViewerTile extends StatelessWidget {
  final File file;
  final bool selected;
  final void Function(File file) onToggleSelection;
  const UploaderViewerTile({
    required this.file,
    this.selected = false,
    required this.onToggleSelection,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      width: 160,
      height: 100,
      title: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onToggleSelection(file),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Checkbox(
                  value: selected,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) => onToggleSelection(file),
                ),
                Expanded(
                  child: Tooltip(
                    message: file.path.split('/').last,
                    child: Text(
                      file.path.split('/').last,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onToggleSelection(file),
          child: viewr(file, context),
        ),
      ),
    );
  }
}

Widget viewr(File file, BuildContext context) {
  final String fileExtension = file.path.split('.').last;
  List imagePreviewExtensions = ['png', 'jpg', 'jpeg', 'svg', 'webp'];
  if (imagePreviewExtensions.contains(fileExtension)) {
    if (fileExtension == 'svg') {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        child: SvgPicture.file(
          file,
          fit: BoxFit.cover,
        ),
      );
    }
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: Image.file(
        file,
        filterQuality: FilterQuality.low,
        fit: BoxFit.cover,
      ),
    );
  }
  return Icon(
    fileIcon(fileExtension),
    color: Theme.of(context).buttonTheme.colorScheme!.primary,
  );
}
