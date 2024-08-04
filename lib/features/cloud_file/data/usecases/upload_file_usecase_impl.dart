import 'dart:io';

import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/domain/repositories/cloud_file_repository.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/upload_file_usecase.dart';

class UploadFileUseCaseImpl implements UploadFileUseCase {
  late final CloudFileRepository _cloudFileRepository;
  UploadFileUseCaseImpl(final CloudFileRepository cloudFileRepository) {
    _cloudFileRepository = cloudFileRepository;
  }
  @override
  Future<FileReferenceEntity> call(
    File file,
    String path,
    bool convertImage,
  ) async {
    final fileReference = await _cloudFileRepository.uploadFile(
      file,
      path,
      convertImage,
    );
    return fileReference;
  }
}
