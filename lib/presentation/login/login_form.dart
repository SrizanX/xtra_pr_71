import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation/login/login_components.dart';

import 'login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController(text: "adminx");
  final _passwordController = TextEditingController(text: "admin");

  @override
  Widget build(BuildContext context) {
    return buildLoginForm(context);
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  Widget buildLoginForm(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _usernameController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Username",
              hintText: 'Enter your username'),
        ),
        const SizedBox(height: 16),
        PasswordField(controller: _passwordController),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              context.read<LoginBloc>().add(
                  Login(_usernameController.text, _passwordController.text));
            },
            child: const Text("Sign in"),
          ),
        )
      ],
    );
  }
}
