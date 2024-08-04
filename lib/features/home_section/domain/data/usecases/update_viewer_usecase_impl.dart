import 'dart:io';

import 'package:leechineo_panel/core/domain/adapters/path_adapter.dart';
import 'package:leechineo_panel/core/domain/adapters/socket_adapter.dart';
import 'package:leechineo_panel/features/home_section/domain/usecases/update_viewer_usecase.dart';

class UpdateViewerUsecaseImpl implements UpdateViewerUsecase {
  late final PathAdapter _pathAdapter;
  late final SocketAdapter _socketAdapter;
  UpdateViewerUsecaseImpl({
    required PathAdapter pathAdapter,
    required SocketAdapter socketAdater,
  }) {
    _pathAdapter = pathAdapter;
    _socketAdapter = socketAdater;
  }
  @override
  Future<void> exec(String data) async {
    final tempdir = await _pathAdapter.getTemporaryDirectory();
    final directory = '$tempdir/leechineo_panel';
    await _pathAdapter.createDirectoryRecursively(directory);
    final file = File('$directory/home_sections.json');
    file.writeAsStringSync(data);
    _socketAdapter.emit('updated', data);
  }
}
