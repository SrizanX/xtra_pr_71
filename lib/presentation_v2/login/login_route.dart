import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation_v2/login/login_screen.dart';

import 'bloc/login_cubit.dart';
class LoginRoute {
  static const String route = "/login";

  static Route generate() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginScreen(),
      ),
    );
  }
}
