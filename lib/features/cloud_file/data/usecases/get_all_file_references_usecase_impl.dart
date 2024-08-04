import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';
import 'package:leechineo_panel/features/cloud_file/domain/repositories/cloud_file_repository.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_all_files_references_usecase.dart';

class GetAllFileReferencesUseCaseImpl implements GetAllFileReferencesUseCase {
  late final CloudFileRepository _cloudFileRepository;

  GetAllFileReferencesUseCaseImpl(
    final CloudFileRepository cloudFileRepository,
  ) {
    _cloudFileRepository = cloudFileRepository;
  }

  @override
  Future<List<FileReferenceEntity>> call({bool refresh = false}) async {
    final files = await _cloudFileRepository.getAllFiles(refresh: refresh);
    return files;
  }
}
