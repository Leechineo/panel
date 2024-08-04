import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';

class SelectionManagerData {
  final List<FileReferenceEntity> files;
  SelectionManagerData({
    required this.files,
  });

  SelectionManagerData copyWith({
    List<FileReferenceEntity>? files,
  }) {
    return SelectionManagerData(
      files: files ?? this.files,
    );
  }
}

class SelectionManagerMethods {
  final void Function(int oldIndex, int newIndex) reorderFiles;
  final void Function(FileReferenceEntity file) deleteFileSelection;
  final void Function(List<FileReferenceEntity> files) addFiles;
  final void Function(List<FileReferenceEntity> files) setFiles;

  SelectionManagerMethods({
    required this.reorderFiles,
    required this.deleteFileSelection,
    required this.addFiles,
    required this.setFiles,
  });
}

class SelectionManagerPageController
    extends AppController<SelectionManagerData, SelectionManagerMethods> {
  @override
  SelectionManagerMethods defineMethods() {
    return SelectionManagerMethods(
      reorderFiles: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        updateData(
          data.copyWith(
            files: data.files
              ..insert(
                newIndex,
                data.files.removeAt(oldIndex),
              ),
          ),
        );
      },
      deleteFileSelection: (file) {
        final selectedFile = data.files.where(
          (element) => element.toString() == file.toString(),
        );
        if (selectedFile.isNotEmpty) {
          updateData(
            data.copyWith(
              files: data.files..remove(selectedFile.first),
            ),
          );
        }
      },
      addFiles: (files) {
        updateData(
          data.copyWith(
            files: data.files..addAll(files),
          ),
        );
      },
      setFiles: (files) {
        updateData(
          data.copyWith(
            files: [...files],
          ),
        );
      },
    );
  }

  @override
  SelectionManagerData defineData() {
    return SelectionManagerData(
      files: [],
    );
  }
}
