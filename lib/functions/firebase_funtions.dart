import 'package:chatapp/persentation/chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

singUpFunction({
  required BuildContext context,
  required String email,
  required String password,
  required String name,
  required String phone,
}) async {
  final CollectionReference user =
      FirebaseFirestore.instance.collection("Users");
  try {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (_auth.currentUser!.email != null) {
      user.doc(_auth.currentUser!.email).set(
        {"Name": name, "Phone": phone},
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak-password") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password should be at least 6 character",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    } else if (e.code == "email-already-in-use") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Email already in use", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("something wrong", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    }
  }
}

loginFunction({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    await _auth.signInWithEmailAndPassword(email: email, password: password);

    if (_auth.currentUser != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(),
        ),
        (route) => false,
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == "invalid-credential") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email and password incorrect",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Something Worng",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }
}
