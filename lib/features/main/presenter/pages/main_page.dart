import 'package:flutter/cupertino.dart';
import 'package:leechineo_panel/core/presenter/components/app_file_picker/app_file_picker.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';

class MainPage extends StatefulWidget {
  final CloudFilesMainPageController cloudFilesMainPageController;
  const MainPage({
    required this.cloudFilesMainPageController,
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return AppFlex(
      children: [
        AppFilePicker(
          controller: widget.cloudFilesMainPageController,
        ),
      ],
    );
  }
}
