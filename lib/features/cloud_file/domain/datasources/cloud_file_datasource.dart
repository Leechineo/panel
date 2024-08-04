import 'dart:io';

import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';

abstract class CloudFileDatasource {
  Future<List<FileReferenceEntity>> getAllFiles({bool refresh = false});
  Future<FileReferenceEntity> uploadFile(
    File file,
    String path,
    bool convertImage,
  );
}
