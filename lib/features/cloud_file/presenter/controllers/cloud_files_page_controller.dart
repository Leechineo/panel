import 'package:leechineo_panel/core/domain/errors/app_error.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_picker_extension_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/app_file_exporer_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_all_files_references_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';

class CloudFilesPageData {
  final List<FileReferenceEntity> files;
  final List<FileReferenceEntity> selectedFiles;
  final List<AppFileExplorer> explorerItems;
  final List<String> currentExplorerPath;
  final bool loading;

  CloudFilesPageData({
    required this.files,
    required this.loading,
    required this.selectedFiles,
    required this.explorerItems,
    required this.currentExplorerPath,
  });

  CloudFilesPageData copyWith({
    bool? loading,
    List<FileReferenceEntity>? files,
    List<FileReferenceEntity>? selectedFiles,
    List<AppFileExplorer>? explorerItems,
    List<String>? currentExplorerPath,
  }) {
    return CloudFilesPageData(
      files: files ?? this.files,
      loading: loading ?? this.loading,
      selectedFiles: selectedFiles ?? this.selectedFiles,
      explorerItems: explorerItems ?? this.explorerItems,
      currentExplorerPath: currentExplorerPath ?? this.currentExplorerPath,
    );
  }
}

class CloudFilesPageMethods {
  final void Function() loadFiles;
  final List<AppFileExplorer> Function() getRemoteExplorerItems;
  final void Function(String path) goToPath;
  final void Function() goToPreviousPath;
  final List<FileReferenceEntity> Function(FileReferenceEntity file)
      toggleFileSelection;
  final bool Function(FileReferenceEntity file) getFileSelectionState;
  final String Function(String fileId) getFileUrl;

  CloudFilesPageMethods({
    required this.loadFiles,
    required this.getRemoteExplorerItems,
    required this.goToPath,
    required this.goToPreviousPath,
    required this.toggleFileSelection,
    required this.getFileSelectionState,
    required this.getFileUrl,
  });
}

class CloudFilesPageController
    extends AppController<CloudFilesPageData, CloudFilesPageMethods> {
  final bool multiple;
  final List<AppFilePickerExtension> allowedExtensions;

  late final GetAllFileReferencesUseCase _getAllFileReferencesUseCase;
  late final GetFileUrlUseCase _getFileUrlUseCase;

  CloudFilesPageController({
    required final GetAllFileReferencesUseCase getAllFileReferencesUseCase,
    required final GetFileUrlUseCase getFileUrlUseCase,
    this.multiple = true,
    this.allowedExtensions = const [],
  }) {
    _getAllFileReferencesUseCase = getAllFileReferencesUseCase;
    _getFileUrlUseCase = getFileUrlUseCase;
    methods.loadFiles();
  }

  @override
  CloudFilesPageMethods defineMethods() {
    return CloudFilesPageMethods(
      loadFiles: () async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          final fileReferences = await _getAllFileReferencesUseCase();
          updateData(
            data.copyWith(
              files: fileReferences,
            ),
          );
          updateData(
            data.copyWith(
              explorerItems: methods.getRemoteExplorerItems(),
            ),
          );
        } catch (e) {
          if (e is AppError) {
            catchError(e);
          }
        }
        updateData(
          data.copyWith(
            loading: false,
          ),
        );
      },
      getRemoteExplorerItems: () {
        List<FileReferenceEntity> filteredFilesByExtesion;
        if (allowedExtensions.isEmpty) {
          filteredFilesByExtesion = data.files;
        } else {
          filteredFilesByExtesion = data.files
              .where(
                (element) => allowedExtensions
                    .map(
                      (e) => e.type,
                    )
                    .contains(
                      element.path.split('.').last,
                    ),
              )
              .toList();
        }

        final List<String?> fragmentedFilesPath = filteredFilesByExtesion
            .map((file) {
              final List<String> path = file.path.split('/');
              if (path.length >= data.currentExplorerPath.length) {
                List<String> currentPath =
                    path.sublist(0, data.currentExplorerPath.length);
                if (currentPath.toString() ==
                    data.currentExplorerPath.toString()) {
                  return path[data.currentExplorerPath.length];
                }
              }
              return null;
            })
            .where((pathFile) => pathFile != null && pathFile.isNotEmpty)
            .toList();
        final items = Set.from(fragmentedFilesPath)
            .map((path) {
              if (path is String) {
                final bool isFolder = !path.contains('.');
                String id = '';
                if (!isFolder) {
                  id = data.files
                      .firstWhere((file) => file.path.contains(path))
                      .id;
                }
                return AppFileExplorer(
                  id: id,
                  name: path,
                  path: path,
                  createdAt: DateTime.now(),
                  type: isFolder ? 'folder' : 'file',
                );
              }
              return null;
            })
            .where((element) => element != null)
            .toList()
          ..sort(
            (a, b) {
              if (a?.type == 'folder' && b?.type == 'file') {
                return -1;
              }
              if (a?.type == 'file' && b?.type == 'folder') {
                return 1;
              }
              return 0;
            },
          );
        if (data.currentExplorerPath.isNotEmpty) {
          items.insert(
            0,
            AppFileExplorer(
              id: 'back_folder',
              name: '...',
              type: 'back_folder',
              createdAt: DateTime.now(),
              path: '',
            ),
          );
        }
        return items.whereType<AppFileExplorer>().toList();
      },
      goToPath: (path) {
        updateData(
          data.copyWith(
            currentExplorerPath: data.currentExplorerPath..add(path),
            explorerItems: methods.getRemoteExplorerItems(),
          ),
        );
      },
      goToPreviousPath: () {
        updateData(
          data.copyWith(
            currentExplorerPath: data.currentExplorerPath..removeLast(),
            explorerItems: methods.getRemoteExplorerItems(),
          ),
        );
      },
      toggleFileSelection: (file) {
        final selectedFile = data.selectedFiles.where(
          (element) => element.toString() == file.toString(),
        );
        if (selectedFile.isNotEmpty) {
          updateData(
            data.copyWith(
              selectedFiles: data.selectedFiles..remove(selectedFile.first),
            ),
          );
        } else {
          if (multiple) {
            updateData(
              data.copyWith(
                selectedFiles: data.selectedFiles..add(file),
              ),
            );
          } else {
            updateData(
              data.copyWith(
                selectedFiles: [file],
              ),
            );
          }
        }
        return data.selectedFiles;
      },
      getFileSelectionState: (file) {
        return data.selectedFiles
            .where(
              (element) => element.toString() == file.toString(),
            )
            .isNotEmpty;
      },
      getFileUrl: (fileId) {
        return _getFileUrlUseCase.call(fileId);
      },
    );
  }

  @override
  CloudFilesPageData defineData() {
    return CloudFilesPageData(
      files: [],
      selectedFiles: [],
      explorerItems: [],
      currentExplorerPath: [],
      loading: false,
    );
  }
}
