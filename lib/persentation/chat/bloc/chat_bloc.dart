import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chatapp/functions/db_functions.dart';
import 'package:chatapp/models/chat_model.dart';
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
    myChannel.sink.close();
    return super.close();
  }

  void _sendButtonClick(
    SendButtonClickEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    ChatModel model = ChatModel(
      message: event.message,
      code: "0",
    );
    await DbChatFunctions.addChatList(chatModel: model);
    chatList.add(model);

    try {
      myChannel.sink.add(event.message);

      await for (var message in myChannel.stream) {
        ChatModel model = ChatModel(
          message: message,
          code: myChannel.hashCode.toString(),
        );
        await DbChatFunctions.addChatList(chatModel: model);
        chatList.add(model);
        return emit(ChatSuccessState());
      }
    } catch (error) {
      log("eroorrr");
      return emit(ChatErrorState(error: error.toString()));
    }
  }
}
