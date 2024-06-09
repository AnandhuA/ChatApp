import 'dart:developer';

import 'package:chatapp/core/size.dart';
import 'package:chatapp/core/validation.dart';
import 'package:chatapp/persentation/authentication/login_screen.dart';
import 'package:chatapp/persentation/authentication/widgets/custom_button.dart';
import 'package:chatapp/persentation/authentication/widgets/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                constHeight50,
                Text(
                  "SignUp",
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.purple.shade50,
                  ),
                ),
                constHeight50,
                TextFieldWidget(
                  validation: validateUsername,
                  controller: _nameController,
                  label: "Name",
                ),
                constHeight20,
                TextFieldWidget(
                  validation: validateEmail,
                  controller: _emailController,
                  label: "Email",
                  keyboard: TextInputType.emailAddress,
                ),
                constHeight20,
                TextFieldWidget(
                  validation: validateMobileNumber,
                  controller: _phoneController,
                  label: "Phone",
                  maxlength: 10,
                  keyboard: TextInputType.phone,
                ),
                constHeight20,
                TextFieldWidget(
                  validation: validatePassword,
                  controller: _passwordController,
                  label: "Password",
                  obscureText: true,
                ),
                constHeight40,
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      log("ok");
                    }
                  },
                  title: "SignUp",
                ),
                constHeight40,
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account?  ",
                      style: const TextStyle(color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'LogIn',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => LoginScreen(),
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
    );
  }
}
