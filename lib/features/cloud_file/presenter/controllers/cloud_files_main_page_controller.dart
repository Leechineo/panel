import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_picker_extension_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_all_files_references_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/upload_file_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_page_controller.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/selection_manager_page_controller.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/uploader_page_controller.dart';

class CloudFilesMainData {
  final UploaderPageController uploaderPageController;
  final CloudFilesPageController cloudFilesPageController;
  final SelectionManagerPageController selectionManagerPageController;

  CloudFilesMainData({
    required this.cloudFilesPageController,
    required this.selectionManagerPageController,
    required this.uploaderPageController,
  });

  CloudFilesMainData copyWith({
    UploaderPageController? uploaderPageController,
    CloudFilesPageController? cloudFilesPageController,
    SelectionManagerPageController? selectionManagerPageController,
    List<File>? files,
  }) {
    return CloudFilesMainData(
      cloudFilesPageController:
          cloudFilesPageController ?? this.cloudFilesPageController,
      selectionManagerPageController:
          selectionManagerPageController ?? this.selectionManagerPageController,
      uploaderPageController:
          uploaderPageController ?? this.uploaderPageController,
    );
  }
}

class CloudFilesMainMethods {
  final void Function() pickFiles;
  final bool Function(File file) isFile;
  final List<File> Function(List<File> files) removeDuplicateFiles;

  CloudFilesMainMethods({
    required this.pickFiles,
    required this.isFile,
    required this.removeDuplicateFiles,
  });
}

class CloudFilesMainPageController<V>
    extends AppController<CloudFilesMainData, CloudFilesMainMethods> {
  late final UploaderPageController uploaderPageController;
  late final CloudFilesPageController cloudFilesPageController;
  late final SelectionManagerPageController selectionManagerPageController;

  CloudFilesMainPageController({
    required final UploadFileUseCase uploadFileUseCase,
    required final GetAllFileReferencesUseCase getAllFileReferencesUseCase,
    required final GetFileUrlUseCase getFileUrlUseCase,
    final multiple = true,
    final allowedExtensions = const <AppFilePickerExtension>[],
    final bool convertImage = false,
    final bool customizablePath = false,
    final String path = '',
    final String prePath = '',
  })  : uploaderPageController = UploaderPageController(
          uploadFileUseCase,
          multiple: multiple,
          allowedExtensions: allowedExtensions,
          convertImage: convertImage,
          customizablePath: customizablePath,
          path: path,
          prePath: prePath,
        ),
        cloudFilesPageController = CloudFilesPageController(
          getAllFileReferencesUseCase: getAllFileReferencesUseCase,
          getFileUrlUseCase: getFileUrlUseCase,
          allowedExtensions: allowedExtensions,
          multiple: multiple,
        ),
        selectionManagerPageController = SelectionManagerPageController();

  @override
  CloudFilesMainMethods defineMethods() {
    return CloudFilesMainMethods(
      pickFiles: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: uploaderPageController.data.allowedExtensions.isNotEmpty
              ? FileType.custom
              : FileType.any,
          allowedExtensions: uploaderPageController.data.allowedExtensions
              .map((e) => e.type)
              .toList(),
          allowMultiple: uploaderPageController.data.multiple,
        );
        if (result != null) {
          List<File> selectedFiles = result.files
              .map((platformFile) => File(platformFile.path!))
              .where(
                (file) => methods.isFile(file),
              )
              .toList();
          if (uploaderPageController.data.multiple) {
            uploaderPageController.methods.setFiles(
              methods.removeDuplicateFiles([
                ...uploaderPageController.data.files,
                ...selectedFiles,
              ]),
            );
          } else {
            uploaderPageController.methods.setFiles([
              selectedFiles.first,
            ]);
          }
        }
      },
      isFile: (file) {
        return file.existsSync() &&
            file.statSync().type == FileSystemEntityType.file;
      },
      removeDuplicateFiles: (files) {
        Set<String> uniquePaths = {};
        List<File> uniqueFiles = [];
        for (File file in files) {
          if (uniquePaths.add(file.path)) {
            uniqueFiles.add(file);
          }
        }
        return uniqueFiles;
      },
    );
  }

  @override
  CloudFilesMainData defineData() {
    return CloudFilesMainData(
      cloudFilesPageController: cloudFilesPageController,
      selectionManagerPageController: selectionManagerPageController,
      uploaderPageController: uploaderPageController,
    );
  }
}
