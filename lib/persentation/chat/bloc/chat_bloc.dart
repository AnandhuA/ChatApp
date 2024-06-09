import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'chat_event.dart';
part 'chat_state.dart';

List chatList = [];

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendButtonClickEvent>(_sendButtonClick);
  }

  FutureOr<void> _sendButtonClick(
    SendButtonClickEvent event,
    Emitter<ChatState> emit,
  ) {
    emit(ChatLoadingState());

    chatList.add(event.message);
    emit(ChatSuccessState());
  }
}
