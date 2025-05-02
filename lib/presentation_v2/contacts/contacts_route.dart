import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:xtra_pr_71/presentation_v2/contacts/contacts_screen.dart';

import 'bloc/contacts_cubit.dart';

class ContactsRoute {
  static const String route = "/contacts";

  static Route generate() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => ContactsCubit(),
        child: const ContactsScreen(),
      ),
    );
  }

  static generateGoRoute() {
    return GoRoute(
      path: route,
      builder: (_, state) => BlocProvider(
        create: (context) => ContactsCubit(),
        child: const ContactsScreen(),
      ),
    );
  }
}
