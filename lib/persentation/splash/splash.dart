import 'dart:async';

import 'package:chatapp/persentation/authentication/signup_screen.dart';
import 'package:chatapp/persentation/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Text(
          "Loading....",
        ),
      ),
    );
  }

  void checkLogin() async {
    final firebaseAuth = FirebaseAuth.instance;

    if (firebaseAuth.currentUser == null) {
      Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignupScreen(),
          ),
        );
      });
    } else {
      Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(),
          ),
        );
      });
    }
  }
}
