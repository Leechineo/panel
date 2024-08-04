import 'dart:convert';

import 'package:leechineo_panel/features/cloud_file/domain/entities/file_reference_entity.dart';

class FileReferenceModel extends FileReferenceEntity {
  FileReferenceModel({
    required super.id,
    required super.path,
    required super.type,
    required super.createdAt,
  });

  FileReferenceModel copyWith({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'path': path,
      'type': type,
      'createdAt': createdAt.toString(),
    };
  }

  factory FileReferenceModel.fromMap(Map<String, dynamic> map) {
    return FileReferenceModel(
      id: map['id'] as String,
      path: map['path'] as String,
      type: map['type'] as String,
      createdAt: DateTime.tryParse(map['createdAt']) ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FileReferenceModel.fromJson(String source) =>
      FileReferenceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FileReferenceModel(id: $id, path: $path, type: $type, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant FileReferenceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.path == path &&
        other.type == type &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ path.hashCode ^ type.hashCode ^ createdAt.hashCode;
  }
}
