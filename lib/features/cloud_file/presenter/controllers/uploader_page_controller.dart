import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/domain/errors/app_error.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_picker_extension_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/upload_file_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/widgets/uploading_dialog.dart';

class UploaderPageData {
  final List<File> files;
  final List<File> selectedFiles;
  final bool uploading;

  final bool multiple;
  final bool compressable;
  final bool customizablePath;
  final String prePath;
  final List<AppFilePickerExtension> allowedExtensions;
  final bool convertImage;
  final String path;
  final bool uploaded;

  UploaderPageData({
    required this.files,
    required this.selectedFiles,
    required this.uploading,
    required this.multiple,
    required this.compressable,
    required this.customizablePath,
    required this.prePath,
    required this.allowedExtensions,
    required this.convertImage,
    required this.path,
    required this.uploaded,
  });

  UploaderPageData copyWith({
    List<File>? files,
    List<File>? selectedFiles,
    bool? uploading,
    bool? multiple,
    bool? compressable,
    bool? customizablePath,
    String? prePath,
    List<AppFilePickerExtension>? allowedExtensions,
    bool? convertImage,
    String? path,
    bool? uploaded,
  }) {
    return UploaderPageData(
      files: files ?? this.files,
      selectedFiles: selectedFiles ?? this.selectedFiles,
      uploading: uploading ?? this.uploading,
      multiple: multiple ?? this.multiple,
      allowedExtensions: allowedExtensions ?? this.allowedExtensions,
      compressable: compressable ?? this.compressable,
      convertImage: convertImage ?? this.convertImage,
      customizablePath: customizablePath ?? this.customizablePath,
      path: path ?? this.path,
      prePath: prePath ?? this.prePath,
      uploaded: uploaded ?? this.uploaded,
    );
  }
}

class UploaderPageMethods {
  final void Function() selectAllFiles;
  final void Function() deleteSelectedFiles;
  final void Function(File file) toggleFileSelection;
  final void Function(BuildContext context) sendFiles;
  final void Function(List<File> files) setFiles;

  UploaderPageMethods({
    required this.selectAllFiles,
    required this.deleteSelectedFiles,
    required this.toggleFileSelection,
    required this.sendFiles,
    required this.setFiles,
  });
}

class UploaderPageController<V>
    extends AppController<UploaderPageData, UploaderPageMethods> {
  final bool multiple;
  final String path;
  final String prePath;
  final bool convertImage;
  final bool customizablePath;

  final List<AppFilePickerExtension<V>>? allowedExtensions;

  late final UploadFileUseCase _uploadFileUseCase;

  UploaderPageController(
    final UploadFileUseCase uploadFileUseCase, {
    this.multiple = false,
    this.allowedExtensions,
    this.convertImage = false,
    this.customizablePath = false,
    this.path = '',
    this.prePath = '',
  }) {
    _uploadFileUseCase = uploadFileUseCase;
  }

  @override
  UploaderPageMethods defineMethods() {
    return UploaderPageMethods(
      selectAllFiles: () {
        if (data.selectedFiles.length == data.files.length) {
          updateData(
            data.copyWith(
              selectedFiles: [],
            ),
          );
        } else {
          updateData(
            data.copyWith(
              selectedFiles: [...data.files],
            ),
          );
        }
      },
      deleteSelectedFiles: () {
        if (data.files.length == data.selectedFiles.length) {
          return updateData(
            data.copyWith(
              files: [],
              selectedFiles: [],
            ),
          );
        }
        for (File file in data.selectedFiles) {
          final int index = data.files.indexOf(file);
          updateData(
            data.copyWith(
              files: data.files..removeAt(index),
              selectedFiles: [],
            ),
          );
        }
      },
      toggleFileSelection: (file) {
        if (data.selectedFiles.contains(file)) {
          final int index = data.selectedFiles.indexOf(file);
          updateData(
            data.copyWith(
              selectedFiles: data.selectedFiles..removeAt(index),
            ),
          );
        } else {
          updateData(
            data.copyWith(
              selectedFiles: data.selectedFiles..add(file),
            ),
          );
        }
      },
      setFiles: (files) {
        updateData(
          data.copyWith(
            files: files,
          ),
        );
      },
      sendFiles: (context) async {
        try {
          final recentUploadFiles = <FileReferenceEntity>[];
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => builder(
              builder: (context, data) {
                return UploadingDialog(
                  uploading: data.uploading,
                );
              },
            ),
          );
          for (final file in data.files) {
            final fileReference = await _uploadFileUseCase(
              file,
              data.prePath + data.path,
              data.convertImage,
            );
            recentUploadFiles.add(fileReference);
          }
          dispatchEvent(
            AppControllerEvent(
              id: 'uploadedFiles',
              data: recentUploadFiles,
            ),
          );
        } catch (e) {
          if (e is AppError) {
            catchError(e);
          }
        }
      },
    );
  }

  @override
  UploaderPageData defineData() {
    return UploaderPageData(
      files: [],
      multiple: multiple,
      selectedFiles: [],
      uploading: false,
      allowedExtensions: allowedExtensions ?? [],
      compressable: false,
      convertImage: convertImage,
      customizablePath: false,
      uploaded: false,
      path: path,
      prePath: prePath,
    );
  }
}
