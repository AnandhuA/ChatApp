
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'web_socket_channel_stub.dart'
    if (dart.library.io) 'web_socket_channel_io.dart'
    if (dart.library.html) 'web_socket_channel_html.dart';

abstract class PlatformWebSocketChannel {
  WebSocketChannel getChannel(String url);
}

PlatformWebSocketChannel getWebSocketChannel() =>
    WebSocketChannelFactory().createPlatformWebSocketChannel();

class WebSocketChannelFactory {
  PlatformWebSocketChannel createPlatformWebSocketChannel() {
    if (kIsWeb) {
      return WebPlatformWebSocketChannel();
    } else {
      return IOPlatformWebSocketChannel();
    }
  }
}
