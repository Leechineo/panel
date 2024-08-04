import 'package:leechineo_panel/features/cloud_file/data/models/file_reference_model.dart';
import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';

class AppFileExplorer {
  String id;
  String name;
  String path;
  String type;
  DateTime createdAt;

  AppFileExplorer({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    required this.createdAt,
  });

  factory AppFileExplorer.fromFileReference(FileReferenceEntity appFile) {
    return AppFileExplorer(
      id: appFile.id,
      name: appFile.path.split('/').last,
      type: appFile.type,
      path: appFile.path,
      createdAt: appFile.createdAt,
    );
  }

  FileReferenceEntity toFileReference({
    String? id,
    String? path,
    String? type,
    DateTime? createdAt,
  }) {
    return FileReferenceModel(
      id: id ?? this.id,
      path: path ?? this.path,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return '{ id: $id, name: $name, type: $type }';
  }
}
