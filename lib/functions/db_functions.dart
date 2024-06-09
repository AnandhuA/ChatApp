import 'package:chatapp/persentation/chat/bloc/chat_bloc.dart';
import 'package:chatapp/persentation/models/chat_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


class DbChatFunctions {
  static const chatDbName = "CHATDB";

  static getChatList() async {
    final chatBox = await Hive.openBox<ChatModel>(chatDbName);
    final list = chatBox.values.toList();
    list.forEach((model) {
      chatList.add(model);
    });
  }

  static addChatList({required ChatModel chatModel}) async {
    final chatBox = await Hive.openBox<ChatModel>(chatDbName);
      await chatBox.add(chatModel);
    
  }
}
