import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation_v2/home/home_route.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.router, size: 120),
              const SizedBox(height: 32),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Admin username"),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Admin password")),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, HomeRoute.route);
                    },
                    child: const Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
