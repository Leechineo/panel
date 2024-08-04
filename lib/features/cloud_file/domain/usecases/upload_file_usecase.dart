import 'dart:io';

import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';

abstract class UploadFileUseCase {
  Future<FileReferenceEntity> call(File file, String path, bool convertImage);
}
