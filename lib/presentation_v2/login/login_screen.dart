import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xtra_pr_71/presentation_v2/login/bloc/login_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/login/bloc/login_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../home/home_route.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.router, size: 120),
              const SizedBox(height: 32),
              TextFormField(
                decoration:  InputDecoration(
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
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Text(AppLocalizations.of(context)!.login);
                    },
                    listener: (context, state) {
                      if (state.loginApiState is LoginSuccessful) {
                        Navigator.popAndPushNamed(context, HomeRoute.route);
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
    );
  }
}
