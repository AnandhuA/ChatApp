// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';

ValueNotifier<List<String>> chats = ValueNotifier([]);

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ValueListenableBuilder(
                valueListenable: chats,
                builder: (context, value, child) {
                  return ListView.separated(
                    itemCount: chats.value.length,
                    reverse: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      final reversedIndex = chats.value.length - 1 - index;
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
                                    chats.value[reversedIndex],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
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
                      chats.value.add(chatController.text);
                      chatController.clear();
                      chats.notifyListeners();
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
      ),
    );
  }
}
