import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xtra_pr_71/navigation/app_routes.dart';
import 'package:xtra_pr_71/presentation/login/login_bloc.dart';
import 'package:xtra_pr_71/presentation/login/login_form.dart';

import '../app/connection_status_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => LoginBloc(Initial()),
        ),
        BlocProvider(
          create: (context) => ConnectionStatusCubit(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: BlocConsumer<LoginBloc, LoginUiState>(
              builder: (ctx, state) {
                if (state is Initial || state is LoginFailed) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FlutterLogo(size: 64),
                      const SizedBox(height: 24),
                      Text("XTRA PR71",
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 44),
                      const LoginForm(),
                      //const ConnectionStatus()
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
              listener: (ctx, state) {
                if (state is LoginSuccessful) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
                if (state is LoginFailed) {
                  Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
