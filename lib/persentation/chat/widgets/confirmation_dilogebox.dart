import 'package:flutter/material.dart';

confirmationDiloge(
    {required BuildContext context,
    required String title,
    required Function confirmBtn,
    required String content}) {

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
         
        ),
        content: Text(
          content,
          
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Text(
              "No",
             
            ),
          ),
          IconButton(
            onPressed: () => confirmBtn(),
            icon: const Text(
              "Yes",
             
            ),
          )
        ],
      );
    },
  );
}
