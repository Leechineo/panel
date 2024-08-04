import 'package:leechineo_panel/core/domain/adapters/socket_adapter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketAdapterImpl implements SocketAdapter {
  final String serverUrl;
  late final io.Socket _socket;

  SocketAdapterImpl({
    required this.serverUrl,
  }) {
    _socket = io.io(
      serverUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
  }

  @override
  bool get isConnected => _socket.connected;

  @override
  Future<void> emit(String event, data) async {
    if (!isConnected) {
      _socket.connect();
    }
    print('Emitindo evento $event');
    _socket.emit(event, data);
  }

  @override
  void on(String event, handler) {
    if (!isConnected) {
      _socket.connect();
    }
    _socket.on(event, handler);
  }

  @override
  Future<void> connect() async {
    _socket.connect();
  }
}
