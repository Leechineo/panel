import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:leechineo_panel/core/domain/adapters/database_adapter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DatabaseAdapterImpl implements DatabaseAdapter {
  static Future<void> start() async {
    final Directory dir = await getApplicationSupportDirectory();
    await Hive.initFlutter(path.absolute(dir.path, 'data'));
  }

  @override
  Future<dynamic> getValue(String collectionName, String key) async {
    final box = await Hive.openBox(collectionName);
    return box.get(key);
  }

  @override
  Future<void> removeValue(String collectionName, String key) async {
    final box = await Hive.openBox(collectionName);
    box.delete(key);
  }

  @override
  Future writeValue(String collectionName, String key, String value) async {
    final box = await Hive.openBox(collectionName);
    box.put(key, value);
  }
}
