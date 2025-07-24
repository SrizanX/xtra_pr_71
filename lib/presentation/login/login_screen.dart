import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../home/home_route.dart';
import 'bloc/login_cubit.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    // Get bottom inset (keyboard height)
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      // Keep this true
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Change to start
              children: [
                // Add a SizedBox with viewport height to push content down
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                const Icon(Icons.router, size: 120),
                const SizedBox(height: 32),
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(AppLocalizations.of(context)!.adminUsername),
                  ),
                  initialValue: loginCubit.state.username,
                  onChanged: (value) {
                    loginCubit.onUsernameChange(value);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(AppLocalizations.of(context)!.adminPassword),
                  ),
                  initialValue: loginCubit.state.password,
                  onChanged: (value) {
                    loginCubit.onPasswordChange(value);
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      loginCubit.login();
                    },
                    child: BlocConsumer<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state.loginApiState is LoginInProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Text(AppLocalizations.of(context)!.login);
                      },
                      listener: (context, state) {
                        if (state.loginApiState is LoginSuccessful) {
                          context.go(HomeRoute.route);
                        }

                        if (state.loginApiState is LoginFailed) {
                          final errorMessage =
                              (state.loginApiState as LoginFailed).message;
                          Fluttertoast.showToast(msg: errorMessage);
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return Checkbox(
                            value: state.isStaySignedInChecked,
                            onChanged: (value) {
                              loginCubit.onSaveCredentialCheckBoxChange(value!);
                            });
                      },
                    ),
                    Text(AppLocalizations.of(context)!.stayLoggedIn)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
