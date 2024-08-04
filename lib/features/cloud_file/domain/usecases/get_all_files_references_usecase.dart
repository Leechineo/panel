import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';

abstract class GetAllFileReferencesUseCase {
  Future<List<FileReferenceEntity>> call({bool refresh = false});
}
