import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/app_file_picker/app_file_picker.dart';
import 'package:leechineo_panel/features/brand/domain/entities/brand_entity.dart';
import 'package:leechineo_panel/features/brand/presenter/widgets/brand_preview.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';

class BrandIconPicker extends StatefulWidget {
  final BrandEntity brand;
  final bool dark;
  final void Function(FileReferenceEntity icon) onIconSelected;
  final void Function() onIconMirror;
  final String Function(String fileId) getUrl;
  final CloudFilesMainPageController filePickerController;
  const BrandIconPicker({
    required this.brand,
    required this.dark,
    required this.onIconSelected,
    required this.getUrl,
    required this.onIconMirror,
    required this.filePickerController,
    super.key,
  });

  @override
  State<BrandIconPicker> createState() => _BrandIconPickerState();
}

class _BrandIconPickerState extends State<BrandIconPicker> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppFilePicker(
      controller: widget.filePickerController,
      builder: (context, selector) {
        return Column(
          children: [
            BrandPreview(
              brand: widget.brand,
              onIconMirror: widget.onIconMirror,
              getUrl: (fileId) {
                return widget.getUrl(fileId);
              },
              dark: widget.dark,
              selector: selector,
              onIconSelected: (icon) {
                widget.onIconSelected(icon);
              },
            ),
          ],
        );
      },
    );
  }
}
