import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/controllers/cloud_files_main_page_controller.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/pages/cloud_files_page.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/pages/selection_manager_page.dart';
import 'package:leechineo_panel/features/cloud_file/presenter/pages/uploader_page.dart';

class CloudFilesMainPage extends StatefulWidget {
  final CloudFilesMainPageController controller;
  const CloudFilesMainPage({
    required this.controller,
    super.key,
  });

  @override
  State<CloudFilesMainPage> createState() => _CloudFilesMainPageState();
}

class _CloudFilesMainPageState extends State<CloudFilesMainPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 12, 12),
      child: widget.controller.builder(
        builder: (context, controllers) {
          return widget.controller.builder(
            builder: (context, data) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  tooltip: 'Selecionar arquivos locais',
                  onPressed: () {
                    widget.controller.methods.pickFiles();
                  },
                  elevation: 0,
                  child: const Icon(
                    Icons.folder,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endContained,
                bottomNavigationBar: AppCard(
                  borderRadius: BorderRadius.circular(20),
                  child: BottomAppBar(
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        controllers.uploaderPageController.builder(
                            builder: (context, uploaderData) {
                          return FilledButton(
                            onPressed: uploaderData.files.isNotEmpty
                                ? () {
                                    controllers.uploaderPageController.methods
                                        .sendFiles(context);
                                  }
                                : null,
                            child: const Text('Enviar'),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    TabBar(
                      dividerColor: Colors.transparent,
                      labelPadding: const EdgeInsets.all(12),
                      controller: _tabController,
                      tabs: const [
                        Icon(
                          Icons.folder,
                        ),
                        Icon(
                          Icons.cloud,
                        ),
                        Icon(Icons.check_circle_rounded),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    AppCard(
                      height: max<double>(
                          MediaQuery.of(context).size.height - 250, 10),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          UploaderPage(
                            controller: controllers.uploaderPageController,
                            onFilesUploaded: (files) {
                              controllers.selectionManagerPageController.methods
                                  .addFiles(files);
                              _tabController.animateTo(2);
                            },
                          ),
                          CloudFilesPage(
                            controller: controllers.cloudFilesPageController,
                            onSelectionChanged: (files) {
                              controllers.selectionManagerPageController.methods
                                  .setFiles(files);
                            },
                          ),
                          SelectionManagerPage(
                            controller:
                                controllers.selectionManagerPageController,
                            onSelectionDeleted: (file) {
                              controllers.cloudFilesPageController.methods
                                  .toggleFileSelection(file);
                            },
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         controllers.selectionManagerPageController.builder(
                    //           builder: (context, selectorData) {
                    //             return FilledButton(
                    //               onPressed: selectorData.files.isNotEmpty
                    //                   ? () {
                    //                       Navigator.pop<List<FileReferenceEntity>?>(
                    //                         context,
                    //                         selectorData.files,
                    //                       );
                    //                     }
                    //                   : null,
                    //               child: const Text('Concluir'),
                    //             );
                    //           },
                    //         ),
                    //         const Padding(
                    //           padding: EdgeInsets.symmetric(horizontal: 8),
                    //           child: AppDivider(
                    //             vertical: true,
                    //             height: 30,
                    //           ),
                    //         ),
                    //         FilledButton(
                    //           onPressed: () {
                    //             Navigator.pop(context);
                    //           },
                    //           child: const Text('Fechar'),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
