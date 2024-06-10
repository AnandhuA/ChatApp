import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'platform_websocket.dart';

class IOPlatformWebSocketChannel implements PlatformWebSocketChannel {
  @override
  WebSocketChannel getChannel(String url) {
    return IOWebSocketChannel.connect(url);
  }
}
