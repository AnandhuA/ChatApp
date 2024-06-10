import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'platform_websocket.dart';

class WebPlatformWebSocketChannel implements PlatformWebSocketChannel {
  @override
  WebSocketChannel getChannel(String url) {
    return HtmlWebSocketChannel.connect(url);
  }
}
