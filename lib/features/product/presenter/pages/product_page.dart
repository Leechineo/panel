import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/data/adapters/database_adapter_impl.dart';
import 'package:leechineo_panel/core/data/adapters/http_adapter_impl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const MyWidget(),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Future<void> openEditor(BuildContext context) async {
    final databaseAdapter = DatabaseAdapterImpl();
    final httpAdapter = HttpAdapterImpl(databaseAdapter);
    String? jwtToken = await databaseAdapter.getValue('auth', 'token');

    // Get a directory to store the bin file
    final directory = await getApplicationSupportDirectory();
    final binPath = '${directory.path}/product-editor';

    // Copy the bin file from assets to the directory
    final byteData = await rootBundle.load('assets/bin/linux/product-editor');
    final buffer = byteData.buffer;
    await File(binPath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    // Ensure the binary is executable using chmod
    final shell = Shell();
    await shell.run('chmod +x $binPath');

    // Run the binary
    await shell
        .run('$binPath --apiUrl=${httpAdapter.baseUrl} --jwtToken=$jwtToken');

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    openEditor(context);
    return Container();
  }
}
