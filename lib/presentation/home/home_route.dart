import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'bloc/dashboard_cubit.dart';
import 'bloc/data_connectivity_cubit.dart';
import 'bloc/data_limit_cubit.dart';
import 'bloc/home_cubit.dart';
import 'home_screen.dart';

class HomeRoute {
  static const String route = "/home";

  static Route generate() {
    return MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => DashboardCubit()),
          BlocProvider(create: (context) => DataConnectivityCubit()),
          BlocProvider(create: (context) => DataLimitCubit()),
        ],
        child: const HomeScreen(),
      ),
    );
  }

  static generateGoRoute() {
    return GoRoute(
      path: route,
      builder: (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => DashboardCubit()),
          BlocProvider(create: (context) => DataConnectivityCubit()),
          BlocProvider(create: (context) => DataLimitCubit()),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
