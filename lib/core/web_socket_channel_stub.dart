import 'package:web_socket_channel/web_socket_channel.dart';
import 'platform_websocket.dart';

class WebPlatformWebSocketChannel implements PlatformWebSocketChannel {
  @override
  WebSocketChannel getChannel(String url) {
    throw UnsupportedError('Cannot create a WebSocket channel');
  }
}

class IOPlatformWebSocketChannel implements PlatformWebSocketChannel {
  @override
  WebSocketChannel getChannel(String url) {
    throw UnsupportedError('Cannot create a WebSocket channel');
  }
}
