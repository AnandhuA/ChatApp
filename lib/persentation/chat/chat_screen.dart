// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:chatapp/persentation/chat/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final TextEditingController chatController = TextEditingController();

  final myChannel = WebSocket.connect("wss://echo.websocket.org/");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatSuccessState || state is ChatInitial) {
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.separated(
                          itemCount: chatList.length,
                          reverse: true,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            final reversedIndex = chatList.length - 1 - index;
                            return Row(
                              mainAxisAlignment: index % 2 == 0
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.shade400,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.only(
                                        topRight: const Radius.circular(20),
                                        topLeft: const Radius.circular(20),
                                        bottomLeft: Radius.circular(
                                          index % 2 == 0 ? 20 : 0,
                                        ),
                                        bottomRight: Radius.circular(
                                          index % 2 == 0 ? 0 : 20,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: index % 2 == 0
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          chatList[reversedIndex],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      child: Center(
                        child: Text("no"),
                      ),
                    );
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: TextField(
                  controller: chatController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (chatController.text.isNotEmpty) {
                          context.read<ChatBloc>().add(
                                SendButtonClickEvent(
                                  message: chatController.text,
                                ),
                              );
                          chatController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                    hintText: "Type to send...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
