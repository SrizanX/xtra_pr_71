import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:xtra_pr_71/presentation/settings/settings_screen.dart';

import 'items/network_mode/bloc/network_mode_cubit.dart';
import 'items/wifi_settings/bloc/wireless_info_cubit.dart';

class SettingsRoute {
  static const String route = "/settings";

  static Route generate() {
    return MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NetworkModeCubit()),
          BlocProvider(create: (_) => WirelessInfoCubit()),
        ],
        child: const SettingsScreen(),
      ),
    );
  }

  static generateGoRoute() {
    return GoRoute(
      path: route,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NetworkModeCubit()),
          BlocProvider(create: (_) => WirelessInfoCubit()),
        ],
        child: const SettingsScreen(),
      ),
    );
  }
}
