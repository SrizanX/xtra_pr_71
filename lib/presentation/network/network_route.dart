import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../devices/bloc/connected_devices_cubit.dart';
import 'bloc/apn_cubit.dart';
import 'bloc/mac_filter_cubit.dart';
import 'network_screen.dart';

class NetworkRoute {
  static const String route = "/network";

  static GoRoute generateGoRoute() {
    return GoRoute(
      path: route,
      builder: (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ConnectedDevicesCubit()),
          BlocProvider(create: (_) => MacFilterCubit()),
          BlocProvider(create: (_) => ApnCubit()),
        ],
        child: const NetworkScreen(),
      ),
    );
  }
}
