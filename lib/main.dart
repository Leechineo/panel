import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/core_module.dart';
import 'package:leechineo_panel/core/data/adapters/database_adapter_impl.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseAdapterImpl.start();
  runApp(
    ModularApp(
      module: CoreModule(),
      child: const AppWidget(),
    ),
  );
}
