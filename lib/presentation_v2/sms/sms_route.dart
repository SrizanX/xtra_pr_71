import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation_v2/sms/sms_screen.dart';

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
}
