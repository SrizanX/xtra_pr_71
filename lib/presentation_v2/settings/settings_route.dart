import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xtra_pr_71/presentation/home/wireless/bloc/wireless_info_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/settings/items/network_mode/bloc/network_mode_cubit.dart';
import 'package:xtra_pr_71/presentation_v2/settings/settings_screen.dart';

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
}
