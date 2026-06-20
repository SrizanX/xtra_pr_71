import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../contacts/contacts_route.dart';
import '../home/home_route.dart';
import '../login/login_route.dart';
import '../network/network_route.dart';
import 'main_shell.dart';
import '../settings/settings_route.dart';
import '../sms/bloc/sms_cubit.dart';
import '../sms/conversation_screen.dart';
import '../sms/messages_screen.dart';
import '../splash/splash_route.dart';
import '../ussd/bloc/ussd_cubit.dart';
import '../ussd/ussd_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return SplashRoute.generateGoRoute();
      },
    ),
    LoginRoute.generateGoRoute(),

    // Primary app shell with bottom navigation (Home · Data · SMS · Devices ·
    // Settings). Each branch keeps its own navigation state.
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [HomeRoute.generateGoRoute()]),
        StatefulShellBranch(
          routes: [ContactsRoute.generateGoRoute()],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/messages',
              builder: (_, _) => BlocProvider(
                create: (_) => SmsCubit(),
                child: const MessagesScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'ussd',
                  builder: (_, _) => BlocProvider(
                    create: (_) => UssdCubit(),
                    child: const UssdScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [NetworkRoute.generateGoRoute()],
        ),
        StatefulShellBranch(routes: [SettingsRoute.generateGoRoute()]),
      ],
    ),

    // Full-screen conversation (no bottom nav) pushed over the shell.
    GoRoute(
      path: ConversationScreen.route,
      builder: (context, state) {
        final args = state.extra;
        if (args is! ConversationArgs) {
          return const Scaffold(
            body: Center(child: Text('Conversation not found')),
          );
        }
        return ConversationScreen(args: args);
      },
    ),
  ],
);
