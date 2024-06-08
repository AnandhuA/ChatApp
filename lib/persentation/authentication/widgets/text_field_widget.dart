import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType? keyboard;
  final int? maxlength;

  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.label,
      this.obscureText = false,
      this.keyboard,
      this.maxlength});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool visibility;
  @override
  void initState() {
    super.initState();
    visibility = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: visibility,
      keyboardType: widget.keyboard,
      maxLength: widget.maxlength,
      decoration: InputDecoration(
        counterText: "",
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    visibility = !visibility;
                  });
                },
                icon: visibility
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
              )
            : null,
        label: Text(widget.label),
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
