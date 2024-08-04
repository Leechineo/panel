import 'dart:io';

import 'package:leechineo_panel/core/domain/adapters/path_adapter.dart';
import 'package:path_provider/path_provider.dart' as path;

class PathAdapterImpl implements PathAdapter {
  @override
  Future<String> getTemporaryDirectory() async {
    final temporaryDirectory = await path.getTemporaryDirectory();
    if (!(await temporaryDirectory.exists())) {
      await temporaryDirectory.create();
    }
    return temporaryDirectory.path;
  }

  @override
  Future<void> createDirectoryRecursively(String directory) async {
    final dir = Directory(directory);
    await dir.create(recursive: true);
  }
}
