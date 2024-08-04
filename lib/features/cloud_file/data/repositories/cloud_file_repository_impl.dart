import 'dart:io';

import 'package:leechineo_panel/features/cloud_file/domain/datasources/cloud_file_datasource.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/domain/repositories/cloud_file_repository.dart';

class CloudFileRepositoryImpl implements CloudFileRepository {
  late final CloudFileDatasource _cloudFileDatasource;

  CloudFileRepositoryImpl(final CloudFileDatasource cloudFileDatasource) {
    _cloudFileDatasource = cloudFileDatasource;
  }

  @override
  Future<List<FileReferenceEntity>> getAllFiles({bool refresh = false}) async {
    final files = await _cloudFileDatasource.getAllFiles(refresh: refresh);
    return files;
  }

  @override
  Future<FileReferenceEntity> uploadFile(
    File file,
    String path,
    bool convertImage,
  ) async {
    final fileReference = await _cloudFileDatasource.uploadFile(
      file,
      path,
      convertImage,
    );
    return fileReference;
  }
}
