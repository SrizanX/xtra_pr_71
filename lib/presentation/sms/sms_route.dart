import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:xtra_pr_71/presentation/sms/sms_screen.dart';
import 'bloc/sms_cubit.dart';

class SmsRoute {
  static const String route = "/sms";

  static Route generate() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => SmsCubit(),
        child: const SmsScreen(),
      ),
    );
  }

  static generateGoRoute() {
    return GoRoute(
      path: route,
      builder: (_, state) => BlocProvider(
        create: (context) => SmsCubit(),
        child: const SmsScreen(),
      ),
    );
  }
}
