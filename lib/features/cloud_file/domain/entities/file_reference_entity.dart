abstract class FileReferenceEntity {
  final String id;
  final String path;
  final String type;
  final DateTime createdAt;

  FileReferenceEntity({
    required this.id,
    required this.path,
    required this.type,
    required this.createdAt,
  });
}
