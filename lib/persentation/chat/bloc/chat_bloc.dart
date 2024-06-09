import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chatapp/persentation/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

part 'chat_event.dart';
part 'chat_state.dart';

List<ChatModel> chatList = [];

final myChannel = IOWebSocketChannel.connect("wss://echo.websocket.org/");

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendButtonClickEvent>(_sendButtonClick);
  }

  @override
  Future<void> close() {
    // Close the WebSocket channel when the bloc is closed
    myChannel.sink.close();
    return super.close();
  }

  void _sendButtonClick(
    SendButtonClickEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    chatList.add(ChatModel(message: event.message, code: "0"));

    try {
      myChannel.sink.add(event.message);

      await for (var message in myChannel.stream) {
        chatList.add(
            ChatModel(message: message, code: myChannel.hashCode.toString()));
        emit(ChatSuccessState());
      }
    } catch (error) {
      log("eroorrr");
      emit(ChatErrorState(error: error.toString()));
    }
  }
}
// 185067675