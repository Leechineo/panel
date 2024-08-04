import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/app_file_picker/presenter/widgets/file_picker_dialog.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';

class AppFilePicker extends StatefulWidget {
  final CloudFilesMainPageController controller;

  final Widget Function(
    BuildContext context,
    Future<List<FileReferenceEntity>?> Function() selector,
  )? builder;

  final double? width;
  final double? height;

  const AppFilePicker({
    required this.controller,
    this.width,
    this.height,
    this.builder,
    super.key,
  });

  @override
  State<AppFilePicker> createState() => _AppFilePickerState();
}

class _AppFilePickerState extends State<AppFilePicker> {
  @override
  Widget build(BuildContext context) {
    Future<List<FileReferenceEntity>?> selector() async {
      return showDialog<List<FileReferenceEntity>?>(
        context: context,
        builder: (context) {
          return FilePickerDialog(
            controller: widget.controller,
          );
        },
      );
    }

    return widget.controller.builder(
      builder: (context, data) {
        return widget.builder?.call(context, selector) ??
            AppCard(
              width: widget.width,
              height: widget.height,
              actions: [
                FilledButton(
                  onPressed: () async {
                    await selector();
                  },
                  child: const Icon(Icons.topic),
                )
              ],
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIlustration(
                        AppIlustrations.addFiles,
                        width: 200,
                      ),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }
}
