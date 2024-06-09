import 'dart:developer';
import 'dart:ui';

import 'package:chatapp/core/size.dart';
import 'package:chatapp/core/validation.dart';
import 'package:chatapp/persentation/authentication/signup_screen.dart';
import 'package:chatapp/persentation/authentication/widgets/custom_button.dart';
import 'package:chatapp/persentation/authentication/widgets/text_field_widget.dart';
import 'package:chatapp/persentation/chat/chat_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  constHeight50,
                  Text(
                    "LogIn",
                    style: TextStyle(
                      fontSize: 100,
                      color: Colors.purple[50],
                    ),
                  ),
                  constHeight50,
                  constHeight50,
                  TextFieldWidget(
                    controller: _emailController,
                    label: "Email",
                    validation: validateEmail,
                  ),
                  constHeight20,
                  TextFieldWidget(
                    validation: validatePassword,
                    controller: _passwordController,
                    label: "Password",
                    obscureText: true,
                  ),
                  constHeight50,
                  CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        log("message");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    title: "Login",
                  ),
                  constHeight40,
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account?  ",
                        style: const TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'SignUp',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  constHeight20
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
