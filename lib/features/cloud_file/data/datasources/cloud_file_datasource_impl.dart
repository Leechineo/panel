import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/datasources/app_datasource.dart';
import 'package:leechineo_panel/features/cloud_file/data/errors/invalid_files_error.dart';
import 'package:leechineo_panel/features/cloud_file/data/models/file_reference_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/datasources/cloud_file_datasource.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:mime/mime.dart';

class CloudFileDatasourceImpl extends AppDatasource
    implements CloudFileDatasource {
  late final HttpAdapter _httpAdapter;

  List<FileReferenceEntity> currentFiles = [];

  CloudFileDatasourceImpl(HttpAdapter httpAdapter) {
    _httpAdapter = httpAdapter;
  }
  @override
  Future<List<FileReferenceEntity>> getAllFiles({bool refresh = false}) async {
    final files = await exec<List<FileReferenceEntity>>(() async {
      if (currentFiles.isNotEmpty && !refresh) {
        return currentFiles;
      }
      final response = await _httpAdapter.get('/files');
      if (response.data is! List) {
        throw InvalidFilesError();
      }
      final files = (response.data as List).map(
        (e) => FileReferenceModel.fromMap(e),
      );
      return files.toList();
    });
    return files;
  }

  @override
  Future<FileReferenceEntity> uploadFile(
    File file,
    String path,
    bool convertImage,
  ) async {
    final fileReference = await exec<FileReferenceEntity>(() async {
      final fileBytes = (await file.readAsBytes()).buffer.asUint8List();
      final fileName = file.path.split('/').last;
      final mimeType = MediaType.parse(lookupMimeType(file.path)!);

      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          fileBytes,
          filename: fileName,
          contentType: mimeType,
        ),
      });

      final response = await _httpAdapter.post(
        '/files',
        params: {
          'path': path + fileName,
          'convertImage': convertImage ? 1 : 0,
        },
        data: formData,
      );
      return FileReferenceModel.fromMap(response.data);
    });
    return fileReference;
  }
}
