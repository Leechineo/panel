// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:leechineo_panel/app/core/data/services/file_service.dart';
// import 'package:leechineo_panel/app/core/data/utils/app_database.dart';

void main() {
  group('FileService Tests', () {
    // late FileService fileService;
    setUpAll(() async {
      WidgetsFlutterBinding.ensureInitialized();
      // await AppDatabase.start();
    });

    setUp(() {
      // fileService = FileService();
    });

    test('uploadFile should call postFiles with correct parameters', () async {
      // final File file = File('/home/felipe/Imagens/FB_IMG_1689726102060.jpg');
      // const String path = '/teste';
      // const convertImage = false;

      // await fileService.uploadFile(file, path, convertImage);
    });
  });
}
