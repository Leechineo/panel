abstract class SocketAdapter {
  void on(String event, dynamic Function(dynamic data) handler);
  Future<void> emit(String event, dynamic data);
  Future<void> connect();
  bool get isConnected;
}
