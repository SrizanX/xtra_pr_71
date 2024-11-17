import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordObscured = !isPasswordObscured;
                });
              },
              icon: Icon(isPasswordObscured
                  ? Icons.visibility
                  : Icons.visibility_off)),
          border: const OutlineInputBorder(),
          labelText: "Password",
          hintText: "Enter your password"),
      obscureText: isPasswordObscured,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
