import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  // Singleton setup
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late IO.Socket _socket;

  // Change this to your actual server URL
  final String _serverUrl = '${dotenv.env['API_BASE_URL']}/chat';

  /// Initialize and connect to the Socket.IO server
  void init() {
    _socket = IO.io(
      _serverUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // required for Flutter
          .setExtraHeaders({'authorization': 'Bearer ${CacheHelper.token}'}) // <-- pass token here
          .disableAutoConnect()
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      print('✅ Connected to $_serverUrl');
    });

    _socket.onDisconnect((_) {
      print('❌ Disconnected from $_serverUrl');
    });

    _socket.onError((data) {
      print('⚠️ Socket Error: $data');
    });

    _socket.onReconnect((_) => print('🔄 Reconnecting...'));
    _socket.onReconnectError((data) => print('❌ Reconnect error: $data'));
    _socket.onReconnectAttempt((data) => print('🔁 Reconnect attempt: $data'));
  }

  /// Emit a custom event with data
  void emit(String event, dynamic data) {
    _socket.emit(event, data);
  }

  /// Listen to an event
  void on(String event, Function(dynamic) handler) {
    _socket.on(event, handler);
  }

  // /// Remove a specific event listener
  // void off(String event, [Function? handler]) {
  //   _socket.off(event, handler);
  // }

  /// Disconnect the socket
  void disconnect() {
    _socket.disconnect();
  }

  /// Reconnect the socket
  void reconnect() {
    _socket.connect();
  }

  /// Check if socket is connected
  bool get isConnected => _socket.connected;
}
