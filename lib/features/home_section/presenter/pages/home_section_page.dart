import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leechineo_panel/core/data/adapters/socket_adapter_impl.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_all_files_references_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/upload_file_usecase.dart';
import 'package:leechineo_panel/features/home_section/presenter/controllers/home_section_controller/home_section_controller.dart';
import 'package:leechineo_panel/features/home_section/presenter/widgets/section.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class HomeSectionPage extends StatefulWidget {
  final GetFileUrlUseCase getFileUrlUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final GetAllFileReferencesUseCase getAllFileReferencesUseCase;
  final HomeSectionController controller;
  const HomeSectionPage({
    required this.controller,
    required this.getFileUrlUseCase,
    required this.getAllFileReferencesUseCase,
    required this.uploadFileUseCase,
    super.key,
  });

  @override
  State<HomeSectionPage> createState() => _HomeSectionPageState();
}

class _HomeSectionPageState extends State<HomeSectionPage> {
  final socket = SocketAdapterImpl(
    serverUrl: 'http://localhost:7151/',
  );
  @override
  Widget build(BuildContext context) {
    return widget.controller.builder(
      builder: (context, data) {
        return Scaffold(
          floatingActionButton: data.sections.isNotEmpty
              ? FloatingActionButton(
                  onPressed: widget.controller.methods.addSection,
                  child: const Icon(Icons.add),
                )
              : null,
          body: Builder(
            builder: (context) {
              if (data.sections.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppIlustration(
                        AppIlustrations.underConstruction,
                        width: 300,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Nenhuma seção adicionada',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      FilledButton(
                        onPressed: widget.controller.methods.addSection,
                        child: const Text(
                          'Adicionar seção',
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: FilledButton.icon(
                        onPressed: () {
                          openEditor();
                          socket.connect();
                          socket.on('connect', (data) {
                            print('$data em dart');
                          });
                        },
                        icon: const Icon(Icons.open_in_browser),
                        label: const Text('Visualizar'),
                      ),
                    ),
                    Text(socket.isConnected.toString()),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: FilledButton.icon(
                        onPressed: () {
                          socket.connect();
                          socket.emit('close', 'data');
                        },
                        icon: const Icon(Icons.close),
                        label: const Text('Fechar'),
                      ),
                    ),
                    Column(
                      children: data.sections
                          .map(
                            (e) => Section(
                              section: e,
                              onHiddenUpdated: (value, screenSize) {
                                widget.controller.methods.updateHiddenValue(
                                  value,
                                  screenSize,
                                  e.id,
                                );
                              },
                              elements: e.elements,
                              addElement: (element, elementId, sectionId) {
                                widget.controller.methods.addElement(
                                  element,
                                  sectionId,
                                );
                              },
                              getAllFileReferencesUseCase:
                                  widget.getAllFileReferencesUseCase,
                              getFileUrlUseCase: widget.getFileUrlUseCase,
                              uploadFileUseCase: widget.uploadFileUseCase,
                              onImageSelected:
                                  widget.controller.methods.updateImage,
                              onAddElement:
                                  widget.controller.methods.addElementChild,
                              onDeleteSection:
                                  widget.controller.methods.deleteSection,
                              onElementUpdated: () {
                                widget.controller.updateData(
                                  data,
                                );
                                widget.controller.methods.onUpdate();
                              },
                              onElementDeleted: ({
                                parent,
                                required element,
                              }) {
                                widget.controller.methods.deleteElement(
                                  element: element,
                                  section: e,
                                  parent: parent,
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

Future<void> openEditor() async {
  final directory = await getApplicationSupportDirectory();
  final binPath = '${directory.path}/section_viewer_ws';

  // Copy the bin file from assets to the directory
  final byteData = await rootBundle.load('assets/bin/linux/section_viewer_ws');
  final buffer = byteData.buffer;
  await File(binPath).writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  // Ensure the binary is executable using chmod
  final shell = Shell();
  await shell.run('chmod +x $binPath');

  // Run the binary
  try {
    await shell.run(binPath);
  } catch (e) {
    print('não deu pois $e');
  }
}
