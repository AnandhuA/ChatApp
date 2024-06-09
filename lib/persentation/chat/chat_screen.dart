import 'dart:developer';

import 'package:chatapp/persentation/authentication/login_screen.dart';
import 'package:chatapp/persentation/chat/bloc/chat_bloc.dart';
import 'package:chatapp/persentation/chat/widgets/confirmation_dilogebox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final TextEditingController chatController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        actions: [
          IconButton(
            onPressed: () {
              confirmationDiloge(
                context: context,
                title: "Confirm Logout",
                confirmBtn: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                content: "Are you sure you want to log out?",
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          )
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          _scrollToBottom();
          return Column(
            children: [
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  log(state.toString());

                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: chatList.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: chatList[index].code == "0"
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: chatList[index].code == "0"
                                        ? Colors.purple.shade400
                                        : Colors.purple.shade900,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.only(
                                      topRight: const Radius.circular(20),
                                      topLeft: const Radius.circular(20),
                                      bottomLeft: Radius.circular(
                                        chatList[index].code == "0" ? 20 : 0,
                                      ),
                                      bottomRight: Radius.circular(
                                        chatList[index].code == "0" ? 0 : 20,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        chatList[index].code == "0"
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chatList[index].message,
                                      
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
